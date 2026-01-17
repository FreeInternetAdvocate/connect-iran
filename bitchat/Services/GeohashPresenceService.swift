//
// GeohashPresenceService.swift
// bitchat
//
// Manages the broadcasting of ephemeral presence heartbeats (Kind 20001)
// to geohash location channels.
//
// This is free and unencumbered software released into the public domain.
//

import Foundation
import Combine
import BitLogger
import Tor

/// Service that coordinates the broadcasting of presence heartbeats.
///
/// Behavior:
/// - Monitors location changes via LocationStateManager
/// - Broadcasts Kind 20001 events to low-precision geohash channels
/// - Uses randomized timing (40-80s loop) and decorrelated bursts
/// - Respects privacy by NOT broadcasting to Neighborhood/Block/Building levels
@MainActor
final class GeohashPresenceService: ObservableObject {
    static let shared = GeohashPresenceService()

    private var subscriptions = Set<AnyCancellable>()
    private var heartbeatTimer: Timer?
    private let idBridge = NostrIdentityBridge()
    
    // MARK: - Constants

    // Loop interval range in seconds
    private let loopMinInterval: TimeInterval = 40.0
    private let loopMaxInterval: TimeInterval = 80.0
    
    // Per-broadcast decorrelation delay range in seconds
    private let burstMinDelay: TimeInterval = 2.0
    private let burstMaxDelay: TimeInterval = 5.0

    // Privacy: Only broadcast to these levels
    private let allowedPrecisions: Set<Int> = [
        GeohashChannelLevel.region.precision,    // 2
        GeohashChannelLevel.province.precision,  // 4
        GeohashChannelLevel.city.precision       // 5
    ]

    private init() {
        setupObservers()
    }
    
    /// Start the service (safe to call multiple times)
    func start() {
        SecureLogger.info("Presence: service starting...", category: .session)
        scheduleNextHeartbeat()
    }

    private func setupObservers() {
        // Monitor location channel changes
        LocationStateManager.shared.$availableChannels
            .dropFirst()
            .sink { [weak self] _ in
                self?.handleLocationChange()
            }
            .store(in: &subscriptions)

        // Monitor Tor readiness to kick off heartbeat if it was stalled
        NotificationCenter.default.publisher(for: .TorDidBecomeReady)
            .sink { [weak self] _ in
                self?.handleConnectivityChange()
            }
            .store(in: &subscriptions)
    }

    private func handleLocationChange() {
        // When location changes, we trigger an immediate (but slightly delayed) heartbeat
        // to announce presence in the new zone, then reset the loop.
        SecureLogger.debug("Presence: location changed, scheduling update", category: .session)
        heartbeatTimer?.invalidate()
        
        // Small delay to allow location state to settle
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.performHeartbeat()
            }
        }
    }
    
    private func handleConnectivityChange() {
        SecureLogger.debug("Presence: connectivity restored, triggering heartbeat", category: .session)
        // If we were waiting for network, do it now
        if heartbeatTimer == nil || !heartbeatTimer!.isValid {
            scheduleNextHeartbeat()
        }
    }

    private func scheduleNextHeartbeat() {
        heartbeatTimer?.invalidate()
        let interval = TimeInterval.random(in: loopMinInterval...loopMaxInterval)
        heartbeatTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.performHeartbeat()
            }
        }
    }

    private func performHeartbeat() {
        // Always schedule next loop first ensures continuity even if this one fails/skips
        defer { scheduleNextHeartbeat() }

        // 1. Check preconditions
        guard TorManager.shared.isReady else {
            SecureLogger.debug("Presence: skipping heartbeat (Tor not ready)", category: .session)
            return
        }
        
        // App must be active (or at least we shouldn't broadcast if in background, usually)
        if !TorManager.shared.isForeground() {
            return
        }

        // 2. Get channels
        let channels = LocationStateManager.shared.availableChannels
        guard !channels.isEmpty else { return }

        // 3. Filter and broadcast
        // We use Task + sleep for decorrelation to allow the main runloop to proceed
        for channel in channels {
            // Check privacy restriction
            if !self.allowedPrecisions.contains(channel.geohash.count) {
                continue
            }
            
            // Launch independent task for each channel's delay
            Task { @MainActor in
                // Random delay for decorrelation
                let delay = TimeInterval.random(in: self.burstMinDelay...self.burstMaxDelay)
                let nanoseconds = UInt64(delay * 1_000_000_000)
                try? await Task.sleep(nanoseconds: nanoseconds)
                
                self.broadcastPresence(for: channel.geohash)
            }
        }
    }

    private func broadcastPresence(for geohash: String) {
        do {
            guard let identity = try? idBridge.deriveIdentity(forGeohash: geohash) else {
                return
            }
            
            let event = try NostrProtocol.createGeohashPresenceEvent(
                geohash: geohash,
                senderIdentity: identity
            )
            
            // Send via RelayManager
            let targetRelays = GeoRelayDirectory.shared.closestRelays(
                toGeohash: geohash,
                count: TransportConfig.nostrGeoRelayCount
            )
            
            if !targetRelays.isEmpty {
                NostrRelayManager.shared.sendEvent(event, to: targetRelays)
                SecureLogger.debug("Presence: sent heartbeat for \(geohash) (pub=\(identity.publicKeyHex.prefix(6))...)", category: .session)
            }
        } catch {
            SecureLogger.error("Presence: failed to create event for \(geohash): \(error)", category: .session)
        }
    }
}

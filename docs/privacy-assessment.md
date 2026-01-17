# Connect Iran Privacy Assessment

## Scope
- Mesh transport (BLE) behavior and metadata minimization
- Nostr-based private message fallback (gift-wrapped, end-to-end encrypted)
- Read receipts and delivery acknowledgments
- Logging/telemetry posture and controls

## Summary
- **No accounts, no servers** for mesh; Nostr used only for mutual favorites, with end-to-end Noise encryption encapsulated in gift wraps.
- BLE announces contain only **nickname and Noise pubkey**. No device name, no plaintext identity beyond what the user broadcasts.
- Discovery and flooding incorporate **jitter and TTL caps** to reduce linkability and propagation radius of encrypted payloads.
- UI and storage remain **ephemeral**; message content is not persisted to disk. Minimal state (e.g., read-receipt IDs) is stored for UX and is bounded/cleaned.
- Logging defaults to conservative levels; debug verbosity is suppressed for release builds.

## BLE Privacy Considerations
- **Announce content**: Nickname + Noise public key only.
- **Local Name**: Not used (explicitly disabled). Avoids leaking device/OS identity.
- **Address**: iOS uses BLE MAC randomization; Connect Iran does not attempt to set static addresses.
- **Announce jitter**: Each announce is delayed by a small random jitter to avoid synchronization-based correlation.
- **Scanning**: Foreground scanning uses "allow duplicates" briefly to improve discovery latency; background uses standard scanning parameters.
- **RSSI gating**: The acceptance threshold adapts to nearby density (approx. -95 to -80 dBm) to reduce long-distance observations in dense areas.
- **Fragmentation**: Fragments use write-with-response for reliability (less re-broadcast churn = fewer repeated signals).
- **GATT permissions**: Private characteristic disallows `.read`; we use notify/write/writeWithoutResponse to avoid exposing plaintext attributes.

## Mesh Routing and Multi-hop Limits
- Encrypted relays permitted with random per-hop delay (small jitter) to smooth floods.
- **TTL cap**: Encrypted payloads are capped at 2 hops, limiting metadata spread and path reconstruction risk while enabling close-range relays.

## Nostr Private Messaging Fallback
- **Usage criteria**: Only attempted for mutual favorites or where a Nostr key has been exchanged.
- **Payload confidentiality**: Messages embed a Noise-encrypted packet inside a NIP-17 gift wrap; relays see only random-looking ciphertext.
- **Timestamp handling**: Gift wraps add small randomized offsets to reduce exact timing correlation.
- **Read/delivery acks**: Also encapsulated in gift wraps, preserving content secrecy and minimizing metadata.
- **Relay policy variance**: Some relays apply "web-of-trust" policies and may reject events; Connect Iran tolerates partial delivery and prefers mesh when available.

## Read Receipts and Delivery Acks
- **Routing policy**: Prefer mesh if Noise session established; otherwise use Nostr when mapping exists.
- **Throttling**: Nostr READ acks are queued and rate-limited (~3/s) to prevent relay rate limits during backlogs.
- **Coalescing**: When entering a chat with many unread, only send READ for the latest message, marking older as read locally to reduce metadata.

## Data Retention and State
- **Messages**: Ephemeral in-memory only; history is bounded per chat and trimmed.
- **Read-receipt IDs**: Stored locally for UX continuity; periodically pruned.
- **Favorites**: Noise and optional Nostr keys with petnames; can be wiped via panic action.
- **Panic**: Triple-tap clears keys, sessions, cached state, and disconnects transports.

## Logging and Telemetry
- Centralized `SecureLogger` filters potential secrets and uses OSLog privacy markers.
- Default level: `info`; release builds suppress debug.
- **Zero telemetry**: No data is ever sent to any analytics service.

## Residual Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| RF fingerprinting | Minimal announce content + platform MAC randomization |
| Timing correlation | Announce/relay jitter reduces (but doesn't eliminate) timing analysis |
| Relay metadata | Nostr relays see gift wraps exist, but content is E2E encrypted |

## Iran-Specific Considerations

### Hostile Environment Assumptions
- Assume adversary has deep packet inspection
- Assume adversary monitors BLE spectrum
- Assume device may be seized at any time

### Additional Protections
- **No persistent logs** in release builds
- **Emergency wipe** accessible with minimal interaction
- **No cloud backup** of sensitive data
- **Plausible deniability** — no proof of specific message content

## Recommendations

- [ ] Add optional coalesced READ behavior for large backlogs
- [ ] Expose "low-visibility mode" to reduce scanning in sensitive contexts
- [ ] Allow user-configurable Nostr relay set with "private relays only" toggle
- [ ] Duress PIN that shows decoy data
- [ ] Scheduled auto-wipe after configurable threshold

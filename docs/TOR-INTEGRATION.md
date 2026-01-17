# Tor Integration

> All network traffic routes via Tor by default, with fail-closed behavior when Tor isn't ready.

## Overview

Connect Iran routes all internet traffic through Tor to protect users from network surveillance. This is especially critical in Iran, where deep packet inspection and traffic analysis are common.

**Key principle: Fail closed.** If Tor cannot connect, network features are disabled. We never fall back to clearnet in production.

## Architecture

### Components

- **TorManager** — Boots Tor, manages data directory, exposes SOCKS at `127.0.0.1:39050`
- **TorURLSession** — URLSession configured with SOCKS5 proxy when Tor is ready
- **NostrRelayManager** — Uses TorURLSession for all relay connections
- **GeoRelayDirectory** — Fetches relay lists through Tor

### Traffic Flow

```
App → TorURLSession → SOCKS5 (localhost:39050) → Tor Network → Nostr Relays
```

## Setup

### 1. Build or Obtain Tor Framework

Recommended: Tor C (client-only) with static linking and dead-strip.

```bash
./configure \
  --enable-static \
  --disable-asciidoc --disable-unittests --disable-manpage \
  --disable-zstd --disable-lzma --enable-zlib \
  --disable-systemd --disable-ptrace --disable-seccomp
CFLAGS="-Os -fdata-sections -ffunction-sections" \
LDFLAGS="-Wl,-dead_strip"
```

Build with minimal OpenSSL/LibreSSL (no engines, stripped symbols).

### 2. Add Framework to Xcode

1. Drop xcframework into `Frameworks/`
2. Project expects `Frameworks/tor-nolzma.xcframework` (or update path)
3. Ensure binary includes needed slices (iOS device/simulator, macOS)
4. iOS: Automatically embedded and signed

### 3. Wire Tor Bootstrap

`TorManager.startTor()` supports two paths:

1. **iCepa API** — If `Tor` module present, starts `TORThread` directly
2. **Dynamic load** — `dlopen` of bundled framework, resolves `tor_run_main`

Writes torrc, probes `127.0.0.1:39050` until ready.

### 4. Verify Networking

On launch:
1. `TorManager.startIfNeeded()` called implicitly by `awaitReady()`
2. `NostrRelayManager.connect()` awaits readiness, creates WebSocket via TorURLSession
3. `GeoRelayDirectory.fetchRemote()` awaits readiness, fetches via TorURLSession

## Configuration

### torrc Template

Generated under `Application Support/connect-iran/tor/torrc`:

```
DataDirectory <AppSupport>/connect-iran/tor
ClientOnly 1
SOCKSPort 127.0.0.1:39050
ControlPort 127.0.0.1:39051
CookieAuthentication 1
AvoidDiskWrites 1
MaxClientCircuitsPending 8
```

### Optional macOS Optimization

Detect system Tor binary (e.g., `/opt/homebrew/bin/tor`) and run as subprocess. Keep embedded fallback for portability.

## Development Only

To temporarily allow direct network without Tor (local development only):

```swift
// Add Swift compiler flag: CONNECTIRAN_DEV_ALLOW_CLEARNET
```

**⚠️ NEVER enable in release builds.**

When clearnet bypass is active:
- `TorURLSession` uses direct URLSession
- Console logs warning about clearnet mode
- App still functional for debugging

## Security Notes

### Why Tor?

In Iran's environment:
- **ISPs log all traffic** — Tor hides destination servers
- **Deep packet inspection** — Tor traffic is encrypted and obfuscated
- **IP blocking** — Tor circuits route around blocks
- **Metadata analysis** — Tor obscures connection patterns

### Limitations

- Tor bootstrap takes 10-30 seconds
- Some relays may block Tor exit nodes
- Tor adds latency to all requests
- Bridges may be needed in heavily censored regions

### Bridge Support (Future)

For Iran, we plan to add:
- [ ] Obfs4 bridge support
- [ ] Snowflake integration
- [ ] meek-azure as fallback
- [ ] User-provided bridge configuration

## Fail-Closed Behavior

When Tor is unavailable in release builds:
1. `TorURLSession.shared` returns nil session
2. Network requests fail immediately
3. App logs clear reason for failure
4. User sees "Connecting to secure network..." indefinitely
5. **No clearnet fallback ever occurs**

This ensures users are never accidentally exposed to surveillance.

<p align="center">
  <img src="https://github.com/user-attachments/assets/90133f83-b4f6-41c6-aab9-25d0859d2a47" width="180" height="180" alt="Connect Iran"/>
</p>

<h1 align="center">🇮🇷 Connect Iran</h1>

<p align="center">
  <strong>When they cut the wires, we become the network.</strong>
</p>

<p align="center">
  <a href="https://x.com/connect_iran">𝕏 @connect_iran</a> •
  <a href="https://nufdiran.org">NUFDIRAN</a> •
  <a href="https://bags.fm/3mDtUAjazAyqY58CMxLzYVSvH4AkU4bWwaNEXWsUBAGS">Donate</a>
</p>

<p align="center">
  <em>All proceeds go directly to the <a href="https://nufdiran.org">National Union for Democracy in Iran (NUFDIRAN)</a></em>
</p>

---

## The Crisis

Since **December 28, 2025**, mass protests have erupted across all 31 provinces of Iran, driven by economic collapse—a crashing currency, 40%+ inflation, and soaring costs of basic necessities. What started as economic grievances in Tehran's Grand Bazaar has evolved into widespread calls for political change.

On **January 8, 2026**, the Iranian government imposed one of its most severe internet blackouts in history—a near-total shutdown of mobile data, landlines, and even satellite communications including Starlink. As of mid-January, this blackout has lasted over **170 hours**, making it one of the longest in Iran's history.

**This is not just about convenience.** When the internet goes dark:
- Hospitals lose coordination for emergency care
- Families cannot reach loved ones
- Banks and commerce grind to a halt
- Human rights abuses happen in darkness, undocumented
- People cannot organize, cannot call for help, cannot tell the world what's happening

---

## Our Mission

**Connect Iran** is an open-source initiative to build resilient communication tools that work when traditional infrastructure fails. We're creating technology that:

- **Works Offline** — Bluetooth mesh networks that don't need the internet
- **Thinks Locally** — On-device AI that runs without servers
- **Protects Users** — End-to-end encryption with no accounts, no phone numbers, no trace
- **Navigates Danger** — Offline maps, safe routes, and emergency information
- **Speaks Your Language** — Persian, Kurdish, Azeri, and more

Our goal is simple: **ensure that when governments cut the digital lifeline, people can still connect, communicate, and stay safe.**

---

## What We're Building

### 🔗 Mesh Communication
Peer-to-peer messaging that works without internet, using Bluetooth Low Energy to create local networks between nearby phones. Messages hop from device to device, creating a resilient mesh that can't be shut down from a central point.

### 🧠 On-Device AI (Coming)
Local AI models that run entirely on your phone:
- **Offline translation** between Persian, English, Kurdish, and more
- **Emergency guidance** — first aid, safe routes, protest safety
- **Information summarization** — when you briefly reconnect, catch up fast
- **Voice assistance** — for accessibility and speed

### 🗺️ Offline Navigation (Coming)
Pre-downloaded maps with intelligent routing:
- Navigate without GPS dependency
- Avoid known danger zones
- Find medical care, safe houses, resources
- Works entirely offline

### 📡 Multi-Transport Fallback
When one channel closes, another opens:
- Bluetooth mesh for local communication
- Nostr protocol for global reach when internet returns
- Future: Satellite relay integration, radio backchannels

---

## Technical Foundation

Connect Iran builds on the proven foundation of [BitChat](https://github.com/nickshouse/bitchat), a decentralized mesh messaging protocol. We extend this foundation with Iran-specific features and on-device AI capabilities.

### Core Technologies
- **Noise Protocol** (XX pattern) — End-to-end encryption with forward secrecy
- **Bluetooth LE Mesh** — Multi-hop message relay, up to 7 hops
- **Nostr Protocol** — Decentralized global relay network (290+ relays)
- **On-Device ML** — Local inference with no server dependency

### Security Properties
- **No accounts, no phone numbers** — Nothing to link you to your messages
- **End-to-end encryption** — Only you and your recipient can read messages
- **Forward secrecy** — Past messages stay safe even if keys are compromised
- **Emergency wipe** — Triple-tap to instantly erase everything
- **Traffic analysis resistance** — Padded messages obscure communication patterns

---

## Who We Support

### National Union for Democracy in Iran (NUFDIRAN)

[NUFDIRAN](https://nufdiran.org) is a U.S.-based 501(c)(4) organization founded in 2003, representing Iranian-Americans who support secular democracy and human rights in Iran.

**All fees and donations from Connect Iran go directly to NUFDIRAN** to support:
- Policy advocacy for democratic reform
- Legal support for human rights defenders
- Documentation of abuses for international accountability
- The [Iran Prosperity Project](https://en.wikipedia.org/wiki/Iran_Prosperity_Project) — a roadmap for economic rebuilding

---

## Get Involved

### For Developers
```bash
git clone https://github.com/connect-iran/connect-iran
cd connect-iran
open bitchat.xcodeproj
```

See [Development Setup](#development-setup) below for detailed instructions.

### For Translators
We need help localizing the app into:
- Persian (فارسی)
- Kurdish (کوردی)  
- Azerbaijani (آذربایجانی)
- Arabic (العربية)

### For Security Researchers
Our code is open source. We welcome audits, vulnerability reports, and security improvements.

### For Everyone
- **Spread the word** — Share [@connect_iran](https://x.com/connect_iran) on social media
- **Donate** — Support NUFDIRAN at [bags.fm](https://bags.fm/3mDtUAjazAyqY58CMxLzYVSvH4AkU4bWwaNEXWsUBAGS)
- **Test** — If you're safely outside Iran, help us test and improve

---

## Development Setup

### Prerequisites
- Xcode 15+
- macOS 14+
- iOS 17+ device for Bluetooth testing

### Build Instructions

**Option 1: Xcode**
```bash
cd connect-iran
cp Configs/Local.xcconfig.example Configs/Local.xcconfig
# Add your Developer Team ID to Local.xcconfig
open bitchat.xcodeproj
```

**Option 2: Just**
```bash
brew install just
just run  # Build and run on macOS
```

### Configuration
1. Clone local configs: `cp Configs/Local.xcconfig.example Configs/Local.xcconfig`
2. Add your Developer Team ID to `Configs/Local.xcconfig`
3. Update entitlements: Search and replace `group.chat.bitchat` with your bundle ID

---

## Roadmap

### Phase 1: Foundation ✅
- [x] Bluetooth mesh networking
- [x] Nostr global relay integration
- [x] End-to-end encryption
- [x] Basic iOS/macOS app

### Phase 2: Iran-Specific Features 🚧
- [ ] Persian language support
- [ ] Offline map integration
- [ ] Iran-specific relay optimization
- [ ] Battery optimization for extended outages

### Phase 3: On-Device AI 📋
- [ ] Local translation models
- [ ] Emergency information assistant
- [ ] Offline content summarization
- [ ] Voice interface

### Phase 4: Resilience 📋
- [ ] Satellite communication fallback
- [ ] Radio/analog backchannels
- [ ] Sneakernet mode (USB data courier)
- [ ] Mesh network visualization

---

## Why This Matters

Every internet blackout is an attempt to hide injustice. Tools that allow people to see, document, connect, and navigate—even when cut off—can:

- **Save lives** — Coordinate medical care, warn of danger
- **Preserve truth** — Document abuses for accountability
- **Enable resistance** — Peaceful organization without surveillance
- **Maintain dignity** — Stay connected to family and community

Connect Iran isn't just an app. It's a statement: **that communication is a human right, and no government can take it away.**

---

## Standing on Shoulders

Connect Iran builds on the work of many:

- **[BitChat](https://github.com/nickshouse/bitchat)** — The mesh protocol foundation
- **[Noise Protocol](https://noiseprotocol.org)** — Encryption framework
- **[Nostr](https://nostr.com)** — Decentralized relay network
- **[NetBlocks](https://netblocks.org)** — Internet shutdown monitoring
- **[Access Now](https://accessnow.org)** — Digital rights advocacy

And the countless Iranians who risk everything to speak, organize, and resist.

---

## License

This project is released into the **public domain** under [The Unlicense](LICENSE). 

Use it, modify it, distribute it. No restrictions. **Freedom is the point.**

---

<p align="center">
  <strong>زن، زندگی، آزادی</strong><br/>
  <em>Woman, Life, Freedom</em>
</p>

<p align="center">
  <a href="https://x.com/connect_iran">𝕏</a> •
  <a href="https://nufdiran.org">NUFDIRAN</a> •
  <a href="https://bags.fm/3mDtUAjazAyqY58CMxLzYVSvH4AkU4bWwaNEXWsUBAGS">Donate</a>
</p>

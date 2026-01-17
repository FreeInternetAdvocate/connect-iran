<p align="center">
  <img src="assets/connect_iran.jpg" width="160" alt="Connect Iran"/>
</p>

# Connect Iran Roadmap

> Building resilient communication for when the internet goes dark.

This document outlines our vision for Connect Iran's development. Our goal is to create a comprehensive toolkit for communication, navigation, and information access during internet blackouts and civil unrest.

---

## Vision

**When governments cut the internet, people should still be able to:**
- 📱 Message family and friends
- 🗺️ Navigate safely through their city
- 🏥 Find medical care and resources
- 📰 Access critical information
- 🌍 Tell the world what's happening

---

## Phase 1: Foundation ✅

*Status: Complete*

The mesh networking and encryption foundation inherited from BitChat:

- [x] **Bluetooth LE Mesh Networking**
  - Multi-hop message relay (up to 7 hops)
  - Automatic peer discovery
  - Works completely offline

- [x] **End-to-End Encryption**
  - Noise Protocol (XX pattern)
  - Forward secrecy
  - No key escrow

- [x] **Nostr Integration**
  - Global relay network (290+ relays)
  - Location-based channels
  - Internet fallback when available

- [x] **Privacy Fundamentals**
  - No accounts or registration
  - No phone numbers
  - Emergency wipe (triple-tap)
  - Traffic analysis resistance

---

## Phase 2: Iran-Specific Optimizations 🚧

*Status: In Progress*

### 2.1 Localization
- [ ] **Persian (فارسی) UI** — Full right-to-left support
- [ ] **Kurdish (کوردی) support** — Sorani and Kurmanji
- [ ] **Azerbaijani (آذربایجانی)** — For northwestern Iran
- [ ] **Arabic (العربية)** — For Khuzestan region

### 2.2 Network Resilience
- [ ] **Iran-optimized relay list** — Relays most likely to be accessible
- [ ] **Aggressive reconnection** — Handle intermittent connectivity
- [ ] **Relay health monitoring** — Auto-switch to working relays
- [ ] **Low-bandwidth mode** — Minimize data usage

### 2.3 Battery Optimization
- [ ] **Extended blackout mode** — Maximize battery life during outages
- [ ] **Intelligent sleep cycles** — Balance responsiveness with power
- [ ] **Background mesh participation** — Keep network alive efficiently

### 2.4 Safety Features
- [ ] **Duress PIN** — Alternate PIN that wipes and shows decoy data
- [ ] **Scheduled wipe** — Auto-delete after time threshold
- [ ] **Decoy mode** — App appears as something innocuous
- [ ] **Quick hide** — Instantly minimize to prevent shoulder surfing

---

## Phase 3: On-Device AI 📋

*Status: Planned*

### 3.1 Local Translation Engine
- [ ] **Persian ↔ English** translation
- [ ] **Kurdish ↔ Persian** translation  
- [ ] **Works fully offline** — No server dependency
- [ ] **Conversation mode** — Real-time translation assistance
- [ ] **Document translation** — Translate images of text

### 3.2 Emergency Information Assistant
- [ ] **First aid guidance** — Step-by-step emergency care
- [ ] **Protest safety tips** — Tear gas, kettling, de-escalation
- [ ] **Legal rights information** — Know your rights if detained
- [ ] **Medical facility finder** — From cached/downloaded data
- [ ] **Emergency contacts** — International organizations, embassies

### 3.3 Intelligent Summarization
- [ ] **Catch-up mode** — When connectivity returns, summarize what you missed
- [ ] **News digest** — Summarize multiple sources into key points
- [ ] **Thread summarization** — Condense long group conversations
- [ ] **Priority filtering** — Surface urgent/important messages

### 3.4 Voice Interface
- [ ] **Voice messaging with transcription** — For accessibility
- [ ] **Voice commands** — Hands-free operation
- [ ] **Offline speech recognition** — On-device processing
- [ ] **Text-to-speech** — Read messages aloud

### 3.5 AI Model Strategy
- **Small, efficient models** — Must run on mid-range phones
- **Quantized for mobile** — 4-bit quantization for size/speed
- **Incremental download** — Download only needed language pairs
- **No cloud dependency** — Everything runs locally

---

## Phase 4: Offline Navigation 📋

*Status: Planned*

### 4.1 Offline Maps
- [ ] **OpenStreetMap integration** — Free, open map data
- [ ] **Iran city packs** — Pre-download major cities
- [ ] **Incremental updates** — Sync when connectivity available
- [ ] **Minimal storage footprint** — Compressed vector tiles

### 4.2 Safe Route Planning
- [ ] **Pedestrian routing** — Walking directions
- [ ] **Avoid zones** — Mark and share danger areas
- [ ] **Crowd-sourced hazards** — Community-reported checkpoints
- [ ] **Alternative routes** — Multiple path options

### 4.3 Resource Mapping
- [ ] **Medical facilities** — Hospitals, clinics, pharmacies
- [ ] **Community resources** — Safe houses, aid distribution
- [ ] **Communication points** — Where connectivity exists
- [ ] **Offline updates** — Sync via mesh or sneakernet

### 4.4 Location Privacy
- [ ] **No GPS logging** — Position not stored
- [ ] **Fuzzy sharing** — Share approximate area, not exact location
- [ ] **Offline-first** — GPS works without internet
- [ ] **Optional location** — Full functionality without location access

---

## Phase 5: Advanced Resilience 📋

*Status: Future*

### 5.1 Alternative Transport Layers
- [ ] **Satellite integration** — Starlink/satellite modem support
- [ ] **LoRa radio** — Long-range, low-power mesh
- [ ] **Wi-Fi Direct** — Higher bandwidth local mesh
- [ ] **Sound-based transfer** — Ultrasonic data transmission

### 5.2 Sneakernet Mode
- [ ] **USB data courier** — Export/import message bundles
- [ ] **QR code transfer** — Small data via camera
- [ ] **SD card sync** — Bulk data transfer
- [ ] **Encrypted archives** — Secure physical transport

### 5.3 Network Visualization
- [ ] **Mesh map** — See connected peers and routes
- [ ] **Coverage estimation** — Where can messages reach?
- [ ] **Network health** — Connection quality indicators
- [ ] **Relay status** — Which relays are accessible

### 5.4 Group Coordination
- [ ] **Broadcast channels** — One-to-many announcements
- [ ] **Role-based groups** — Medics, legal observers, journalists
- [ ] **Coordination tools** — Check-ins, status updates
- [ ] **Emergency alerts** — Priority message propagation

---

## Phase 6: Documentation & Evidence 📋

*Status: Future*

### 6.1 Secure Documentation
- [ ] **Photo/video capture** — With automatic metadata stripping
- [ ] **Timestamping** — Cryptographic proof of capture time
- [ ] **Secure storage** — Encrypted media library
- [ ] **Hidden vault** — Plausible deniability for sensitive media

### 6.2 Evidence Preservation
- [ ] **Mesh backup** — Distribute evidence across network
- [ ] **Delayed upload** — Queue for when internet returns
- [ ] **Trusted archives** — Integration with human rights organizations
- [ ] **Chain of custody** — Cryptographic verification

---

## Technical Principles

### Privacy First
- No data we don't absolutely need
- On-device processing wherever possible
- No telemetry, no analytics, no tracking

### Resilience
- Assume the worst: no internet, low battery, hostile environment
- Multiple fallback options for every feature
- Graceful degradation

### Accessibility
- Must work on older/cheaper phones
- Simple UI that works under stress
- Multiple language support

### Open Source
- All code public and auditable
- Community contributions welcome
- No proprietary dependencies

---

## How to Contribute

### Code
- See open issues on GitHub
- Focus areas: localization, AI integration, offline maps
- Security audits especially welcome

### Translation
- Help us reach every Iranian
- Persian, Kurdish, Azeri, Arabic needed
- See `/Localization` directory

### Testing
- Test in simulated blackout conditions
- Report bugs and UX issues
- Help with device compatibility

---

## Timeline

| Phase | Target | Status |
|-------|--------|--------|
| Phase 1: Foundation | Complete | ✅ |
| Phase 2: Iran-Specific | Q1 2026 | 🚧 |
| Phase 3: On-Device AI | Q2 2026 | 📋 |
| Phase 4: Offline Navigation | Q3 2026 | 📋 |
| Phase 5: Advanced Resilience | Q4 2026 | 📋 |
| Phase 6: Documentation | 2027 | 📋 |

*Timelines are aspirational and depend on community contributions and funding.*

---

<p align="center">
  <img src="assets/Flag_of_Iran.svg" width="60" alt="Iran"/>
</p>

<p align="center">
  <strong>زن، زندگی، آزادی</strong><br/>
  <em>Woman, Life, Freedom</em>
</p>

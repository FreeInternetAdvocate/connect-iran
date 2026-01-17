# Connect Iran Privacy Policy

*Last updated: January 2026*

## Our Commitment

Connect Iran is built on a simple principle: **your safety is everything**. In a world where communication can be criminalized and metadata can endanger lives, we've designed this app to know as little about you as possible.

We believe private communication is a fundamental human right—especially for those living under authoritarian regimes.

## Summary

- **No personal data collection** — We don't know your name, email, phone number, or location
- **No servers** — Everything happens on your device and through peer-to-peer connections
- **No tracking** — Zero analytics, telemetry, or user tracking of any kind
- **Open source** — Every line of code is public. Verify these claims yourself.

## What Connect Iran Stores

### On Your Device Only

1. **Identity Key** 
   - A cryptographic key generated on first launch
   - Stored locally in your device's secure enclave
   - Allows you to maintain trusted peer relationships
   - **Never leaves your device**

2. **Nickname**
   - The display name you choose (or auto-generated)
   - Stored only on your device
   - Shared only with peers you communicate with

3. **Message History** (if you enable it)
   - Messages can be saved locally with encryption
   - Stored only on your device
   - You can delete this at any time
   - Default: messages are not persisted

4. **Trusted Peers**
   - Public keys of peers you've verified
   - Stored only on your device
   - Allows you to recognize trusted contacts in future sessions

5. **Offline Maps** (when enabled)
   - Downloaded map data for navigation
   - Stored locally on your device
   - No location data is transmitted

### Temporary Session Data

During each session, Connect Iran temporarily maintains:
- Active peer connections (forgotten when app closes)
- Routing information for message delivery
- Cached messages for offline peers (12 hours maximum)

**All temporary data is cleared when you close the app.**

## What Information is Shared

### With Other Connect Iran Users

When you use Connect Iran, nearby peers can see:
- Your chosen nickname
- Your ephemeral public key (changes each session)
- Messages you send to public channels or directly to them
- Your approximate Bluetooth signal strength (for connection quality only)

### With Channel Members

When you join a location-based channel:
- Your messages are visible to others in that geographic area
- Your nickname appears while you're active
- **Your actual location is never transmitted** — only the geohash area you've joined

## What We DON'T Do

Connect Iran **never**:
- ❌ Collects personal information
- ❌ Tracks your location
- ❌ Stores data on servers (there are none)
- ❌ Shares data with third parties
- ❌ Uses analytics or telemetry
- ❌ Creates user profiles
- ❌ Requires registration or accounts
- ❌ Logs IP addresses
- ❌ Records who you talk to
- ❌ Maintains message history on servers

## Encryption

All communication uses military-grade end-to-end encryption:

| Component | Technology |
|-----------|------------|
| Key Exchange | X25519 (Curve25519) |
| Message Encryption | ChaCha20-Poly1305 |
| Digital Signatures | Ed25519 |
| Handshake | Noise Protocol (XX pattern) |
| Forward Secrecy | New ephemeral keys every session |

**Even if someone steals your phone, they cannot decrypt your past messages.**

## Your Rights and Controls

### Emergency Wipe
**Triple-tap the logo** to instantly delete:
- All messages
- Your identity key
- All peer relationships
- All stored data

This cannot be undone. Use it if your device is about to be seized.

### Leave No Trace
- Close the app and your presence disappears from the network
- No account to delete because there is no account
- No server data to request because there are no servers

### Data Portability
- Your data never leaves your device unless you explicitly export it
- Nothing to "request" from us because we have nothing

## Bluetooth & Permissions

Connect Iran requires Bluetooth permission to function:
- Used **only** for peer-to-peer mesh communication
- **No location data** is accessed through Bluetooth
- Bluetooth is **never** used for tracking
- You can revoke this permission at any time in system settings

### Location Permission (Optional)
- Required only if you want to join geographic channels
- Your precise location is **never transmitted** — only converted to an approximate area code
- You can use the app fully without granting location access

## On-Device AI

When AI features are enabled:
- All AI processing happens **on your device**
- No data is sent to cloud AI services
- AI models are downloaded once and run locally
- AI has no access to your messages unless you explicitly ask for translation/summarization

## Security for Activists

### Designed for Hostile Environments

Connect Iran assumes your adversary is sophisticated:
- **Traffic analysis resistance**: Message sizes are padded to standard lengths
- **No metadata leakage**: We don't know who talks to whom
- **Plausible deniability**: No way to prove you sent any message
- **Seizure resistance**: Emergency wipe, no recoverable data
- **No phone home**: The app never contacts any central server

### What to Know

- Verify peers out-of-band when possible (meet in person, compare fingerprints)
- Use the emergency wipe if your device may be compromised
- Don't trust nicknames alone — verify cryptographic fingerprints
- Keep the app updated for security patches

## Children's Privacy

Connect Iran does not knowingly collect information from anyone, including children. The app has no age verification because it collects no personal information from anyone.

## Changes to This Policy

If we update this policy:
- The "Last updated" date will change
- The updated policy will be included in the app
- Changes will be announced on [@connect_iran](https://x.com/connect_iran)
- No retroactive changes can affect data (since we don't collect any)

## Contact

Connect Iran is an open-source project. For privacy questions:
- View our source code: [GitHub](https://github.com/connect-iran/connect-iran)
- Open an issue for concerns
- Reach out on 𝕏: [@connect_iran](https://x.com/connect_iran)

## Philosophy

Privacy isn't a feature—**it's survival**.

For people living under authoritarian regimes, a metadata trail can mean prison. A contact list can endanger families. A message log can be a death sentence.

Connect Iran proves that modern communication doesn't require surveillance. No accounts, no servers, no compromise. Just people connecting freely, safely, and privately.

**زن، زندگی، آزادی** — Woman, Life, Freedom

---

*This policy is released into the public domain under [The Unlicense](LICENSE), just like Connect Iran itself.*

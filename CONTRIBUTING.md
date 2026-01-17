<p align="center">
  <img src="assets/connect_iran.jpg" width="160" alt="Connect Iran"/>
</p>

# Contributing to Connect Iran

Thank you for your interest in helping Iranians stay connected during internet blackouts. Every contribution matters.

## Ways to Contribute

### 🌍 Translation
Help us reach every Iranian by translating the app into:
- **Persian (فارسی)** — Primary language
- **Kurdish (کوردی)** — Sorani and Kurmanji dialects
- **Azerbaijani (آذربایجانی)** — Northwestern Iran
- **Arabic (العربية)** — Khuzestan region

Translation files are in `/bitchat/Localizable.xcstrings` and `/bitchatShareExtension/Localization/`.

### 💻 Code
Priority areas:
1. **On-Device AI** — Local translation, summarization, voice interfaces
2. **Offline Maps** — OpenStreetMap integration, safe route planning
3. **Battery Optimization** — Extended outage survival mode
4. **Network Resilience** — Alternative transports, bridge support

### 🔐 Security
- Audit the codebase
- Report vulnerabilities responsibly
- Improve encryption implementations
- Test under hostile network conditions

### 📝 Documentation
- Improve setup guides
- Write user tutorials (especially in Persian)
- Document deployment scenarios

### 🧪 Testing
- Test on various iOS/macOS versions
- Test Bluetooth mesh in real-world conditions
- Test under simulated network restrictions
- Report bugs and UX issues

## Development Setup

### Prerequisites
- Xcode 15+
- macOS 14+
- iOS 17+ device (for Bluetooth testing)

### Build
```bash
git clone https://github.com/connect-iran/connect-iran
cd connect-iran
cp Configs/Local.xcconfig.example Configs/Local.xcconfig
# Edit Local.xcconfig with your Team ID
open bitchat.xcodeproj
```

### Quick Run (macOS)
```bash
brew install just
just run
```

## Code Guidelines

### Security First
- Assume all inputs are hostile
- Never log sensitive data
- Use secure coding practices
- When in doubt, fail closed

### Privacy by Design
- Minimize data collection
- Prefer on-device processing
- No telemetry, no analytics
- Make data deletion easy

### Accessibility
- Support right-to-left layouts
- Support VoiceOver
- Use clear, simple language
- Test on older devices

### Code Style
- Follow existing Swift conventions
- Document public interfaces
- Write tests for new features
- Keep functions focused and small

## Pull Request Process

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to your branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### PR Checklist
- [ ] Code compiles without warnings
- [ ] Tests pass
- [ ] Security implications considered
- [ ] Privacy implications considered
- [ ] Documentation updated if needed

## Security Vulnerabilities

**Do NOT open public issues for security vulnerabilities.**

Instead, please reach out privately:
- DM [@connect_iran](https://x.com/connect_iran) on X
- Mark your message as security-related

We will respond within 48 hours and coordinate responsible disclosure.

## Code of Conduct

### Our Standards
- Be respectful and inclusive
- Focus on the mission: helping people in Iran
- Assume good intentions
- Accept constructive criticism gracefully

### Our Mission
Connect Iran exists to help people communicate during crises. We welcome contributors regardless of background, but we are united in our commitment to:
- Human rights
- Free expression
- Privacy as a fundamental right
- Peaceful resistance to authoritarianism

## Recognition

All contributors will be recognized in our release notes. Significant contributions may be highlighted on our social media.

## Questions?

- Open a GitHub Discussion
- Tweet/DM [@connect_iran](https://x.com/connect_iran)
- Check existing issues and PRs

---

<p align="center">
  <img src="assets/Flag_of_Iran.svg" width="60" alt="Iran"/>
</p>

<p align="center">
  <strong>زن، زندگی، آزادی</strong><br/>
  <em>Woman, Life, Freedom</em>
</p>

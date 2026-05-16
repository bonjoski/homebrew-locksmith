# homebrew-locksmith 🔐

[![Homebrew](https://img.shields.io/github/v/release/bonjoski/locksmith?label=homebrew&color=orange)](https://github.com/bonjoski/locksmith)
[![Platform](https://img.shields.io/badge/platform-macOS-blue)](https://github.com/bonjoski/locksmith)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/bonjoski/locksmith/badge)](https://scorecard.dev/viewer/?uri=github.com/bonjoski/locksmith)

The official **Homebrew Tap** for [Locksmith](https://github.com/bonjoski/locksmith) — a secure, biometric-protected keychain vault for macOS.

This tap distributes:
1. **`locksmith`**: The primary CLI and Model Context Protocol (MCP) server.
2. **`summon-locksmith`**: The official [Summon](https://cyberark.github.io/summon) provider, allowing seamless biometric-gated secrets injection into your development and DevOps processes.

> [!TIP]
> **Why use Homebrew?**  
> Installing via Homebrew is the recommended distribution method for macOS. It downloads pre-built, cryptographically signed binaries compiled in a hardened environment, ensuring maximum compatibility with macOS security policies (Touch ID access, sandboxing, and Keychain access group restrictions).

---

## 🚀 Installation

Tap the repository and install the formula:

```bash
# Tap the repository
brew tap bonjoski/locksmith

# Install Locksmith & its Summon provider
brew install locksmith
```

### 🔍 Troubleshooting Tap Issues
If your local Git configuration enforces SSH connections globally, you might encounter a `Permission denied (publickey)` or authentication prompt when tapping. You can bypass this temporary restriction for the install command:

```bash
GIT_CONFIG_GLOBAL=/dev/null brew tap bonjoski/locksmith
```

---

## 🛠️ Verification

Ensure both the core CLI and the Summon provider are installed correctly and match the active version:

```bash
# Verify the core Locksmith CLI
locksmith --version

# Verify the Summon Provider extension
summon-locksmith --version
```

Both should return the active version (e.g., `v2.4.2`).

---

## 💡 Quick Start

Here's how to quickly get started with Locksmith on macOS:

### 1. Store a Secret
Add a secret to your secure macOS Keychain. By default, secrets are biometric-protected:
```bash
locksmith add my-service my-secret-value --expires 30d
```

### 2. Retrieve a Secret
This will trigger a native Touch ID/Apple Watch prompt on your Mac before retrieving the secret:
```bash
locksmith get my-service
```

### 3. Inject with Summon
Use the bundled `summon-locksmith` provider to run commands with environment variables resolved straight from the keychain:

Create a `secrets.yml` file:
```yaml
API_KEY: !var my-service
```

Execute a process securely (Touch ID will prompt to unlock the environment variables):
```bash
summon --provider locksmith -f secrets.yml env | grep API_KEY
```

---

## 🔒 Security & Verification

Each binary distributed through this tap is cryptographically signed and includes a SLSA level 2 attestation. You can verify the integrity of the binary locally:

```bash
# Install the GitHub CLI if you haven't already
brew install gh

# Verify the attestation directly against the release
gh attestation verify $(which locksmith) --repo bonjoski/locksmith
```

For more detailed configuration, MCP server setup, and advanced settings, visit the main [Locksmith Repository](https://github.com/bonjoski/locksmith).

---

## 🤝 Contributing

Contributions to this formula or issues regarding the homebrew formula configuration are welcome! For bugs, feature requests, or contributions to the core Locksmith implementation, please submit them to the [main Locksmith issue tracker](https://github.com/bonjoski/locksmith/issues).

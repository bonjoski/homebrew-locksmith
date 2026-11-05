# Claude Code Guidelines for `homebrew-locksmith`

> **Authoritative Ecosystem Runbook:** [`spanreed/docs/knowledge-base/11-distribution-tap.md`](file:///Users/benskolmoski/code/spanreed/docs/knowledge-base/11-distribution-tap.md)

## Build & Test Commands
- **Audit Formula:** `brew audit --strict Formula/locksmith.rb`
- **Lint Style:** `brew style Formula/`
- **Test Local Install:** `brew install --build-from-source ./Formula/locksmith.rb`
- **Run Integration Test:** `brew test locksmith`

## Packaging & Entitlement Invariants
- Preserve macOS Secure Enclave entitlements (`keychain-access-groups`, `com.apple.security.keychain`).
- Cryptographic SHA-256 verification of all binary resources (`locksmith`, `summon-locksmith`, etc.).
- Multi-component delivery: installs CLI, MCP server, and CyberArk Summon provider simultaneously.

## Commit Invariants
- Mandatory cryptographic signing with GPG key `7BB5B44244E586B0` (`git commit -S`).
- Present diff and test output for explicit user sign-off before committing.

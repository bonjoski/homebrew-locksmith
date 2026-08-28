# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/locksmith-darwin-arm64"
      sha256 "ca36085ab0cea369f2850047516b8046fd0614369196a2d75e15761abebdc99f"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/summon-locksmith-darwin-arm64"
        sha256 "186e59ef88e1f3cc30494a4abdc2b9ebd1dcc4f0628a12f44236c7a4cd3ddf2d"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/git-credential-locksmith-darwin-arm64"
        sha256 "6fd9f0332f75704605f180a87b4d4ab9fae5b3af3f5875b2f4a3d8402d5221ca"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
        resource("git-credential-arm64").stage do
          bin.install "git-credential-locksmith-darwin-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/locksmith-darwin-amd64"
      sha256 "7a5c9961c3ecca703db9a579514eb84e6f0b1aecd78e0b6e0b245a1304d73b0c"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/summon-locksmith-darwin-amd64"
        sha256 "cdf8cdfe003cffe1118f7d699c815c7aade8f85d01c05c6e5e00a4fd26109d2b"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.13/git-credential-locksmith-darwin-amd64"
        sha256 "466993ab8a2d77f3a4590447e103e2e8580f750d47ed3f11c2177ad21c1cc166"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
        resource("git-credential-amd64").stage do
          bin.install "git-credential-locksmith-darwin-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/summon-locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/git-credential-locksmith --version 2>&1")
  end
end

# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/locksmith-darwin-arm64"
      sha256 "1fcbfa749c3b58ddfdf5066f54750563caaf75de09379a501d53f71ef5ba8fab"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/summon-locksmith-darwin-arm64"
        sha256 "06a35eafff38f7436a45210af67588169fda5d6acb9f44e6ed1b1855c096d289"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/git-credential-locksmith-darwin-arm64"
        sha256 "b7a7e19bbe50dd345b9f3a07d62c03e523d8638f8f27d435f285a7c9f6993671"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/locksmith-darwin-amd64"
      sha256 "b39384b8c0a809c044f555051d714a59d3191d5ef9375f11448ed0cdde0f2f4f"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/summon-locksmith-darwin-amd64"
        sha256 "3a4b90b998b4687ff4dad0b19a0f4cd418542f4a37e3fcd4a35fc6bb8cbf8cb5"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.0/git-credential-locksmith-darwin-amd64"
        sha256 "f84231d529a29d2cbeff451dcc5ebb0f3f778a200ba809a75f91bdc8f628f42d"
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

  on_linux do
    url "https://github.com/bonjoski/locksmith/archive/refs/tags/v2.9.0.tar.gz"
    sha256 "164a576940ee1e3d8fb33e3737a55116cd6c8b6aa096c1acd9bd6400841e157e"

    depends_on "go" => :build

    def install
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/locksmith"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
  end
end

# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/locksmith-darwin-arm64"
      sha256 "77e276ebfb646c95d5a5b0f7d6adb5bd2595ffb458f3ee587a741e0f3d2706bb"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/summon-locksmith-darwin-arm64"
        sha256 "54d96b08160769f5a80b17debd37c3bab76f2d7097edb99c460b50ffc65bfa5b"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/git-credential-locksmith-darwin-arm64"
        sha256 "af254b9de64aa00d85593d1b69a9f9aa346fd9ce612043ee46510360686e7861"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/locksmith-cockpit-darwin-arm64"
        sha256 "b86333ce220487da95b2f4dd29da6f802eef588015f9cf18377cc6404ae9950c"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
        resource("git-credential-arm64").stage do
          bin.install "git-credential-locksmith-darwin-arm64" => "git-credential-locksmith"
        end
        resource("cockpit-arm64").stage do
          bin.install "locksmith-cockpit-darwin-arm64" => "locksmith-cockpit"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/locksmith-darwin-amd64"
      sha256 "dc8c89627fc135a7ebd762f33b4b0db50fa59db828032c9940ee48216bc48716"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/summon-locksmith-darwin-amd64"
        sha256 "c967df149a37b0d142508fdcdbad412ccb3f46f7f3e13322c20b3bd3530144f5"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/git-credential-locksmith-darwin-amd64"
        sha256 "337630bc0e67bbb90e4a44b046022339fc967dd8cf4456c8817b306eea827f97"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.2/locksmith-cockpit-darwin-amd64"
        sha256 "4e025152467baf23fa68a5ca4491693d9f9301394dc84843c3722736024a3c7b"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
        resource("git-credential-amd64").stage do
          bin.install "git-credential-locksmith-darwin-amd64" => "git-credential-locksmith"
        end
        resource("cockpit-amd64").stage do
          bin.install "locksmith-cockpit-darwin-amd64" => "locksmith-cockpit"
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
    assert_predicate bin/"locksmith-cockpit", :exist?
  end
end

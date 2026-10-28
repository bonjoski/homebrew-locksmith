# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/locksmith-darwin-arm64"
      sha256 "78fe4a8dfff12e9b72b0be5304b4f06b3f2568ef88207e8f5448c6e8d6af148e"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/summon-locksmith-darwin-arm64"
        sha256 "3305ef8048972d769b357fc1c8c3574c218205598390a3c210f2fe6976f94036"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/git-credential-locksmith-darwin-arm64"
        sha256 "6ec1803683eda33b2574368ea31ffe29d4a9f46ba3a564546b9f554acfd0916b"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/locksmith-cockpit-darwin-arm64"
        sha256 "12720190d4b914a5baff63d48430bdf2357bbb41fd86dbd776333cdf9f17e550"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/locksmith-darwin-amd64"
      sha256 "d17299a1846f02347e20f9be6e3f1927d9589da86bd888c98c256b0ffa8881b3"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/summon-locksmith-darwin-amd64"
        sha256 "c5ca7a7dd31ac0645268a2a7e9d8a9f5dc94d738393143a6692fa7dca6ad001f"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/git-credential-locksmith-darwin-amd64"
        sha256 "54afc82604eb02c678aa937d2ad58c60ab22928b0250e86454528804034bb99a"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.0/locksmith-cockpit-darwin-amd64"
        sha256 "7d9c68735c4f75b5624f2c3ca3169e66527eb94ac436f8dd338ce0f7c14764fc"
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

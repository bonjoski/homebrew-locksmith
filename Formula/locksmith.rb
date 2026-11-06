# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/locksmith-darwin-arm64"
      sha256 "b234936d70a949197e6c8c631bd722ec10e4787c5c6399b05bbc65b345430ba9"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/summon-locksmith-darwin-arm64"
        sha256 "192d16f5d9ff3bff002968f4653f5a4b4d84ee95a00113542b0465963cc124a2"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/git-credential-locksmith-darwin-arm64"
        sha256 "68131df598d456e6c60bc3d8d2b24f42b35d6577b9e217a69e553b2f9a4092f4"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/locksmith-cockpit-darwin-arm64"
        sha256 "a77631666ddf0abd33939a43f34ad9959ef70db8ef14056e17e83c92c0ba42a6"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/locksmith-darwin-amd64"
      sha256 "dfc81fd139093fa975e6b8bddec5a8ab29f2e7d5a80ba223e44b9234bb94a3ea"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/summon-locksmith-darwin-amd64"
        sha256 "0f0dd892769d3c30c423ff9ff03c998fbd96df49ab50004bb37b0665103cf2ef"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/git-credential-locksmith-darwin-amd64"
        sha256 "1a889c0ff18371e7141fa2310ce205e7a1df8d37e02642207bfc3b4a5758d7fd"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.8/locksmith-cockpit-darwin-amd64"
        sha256 "c72c585ea5e0c430ba05845e04f4a91db03fd0a269043bc64cdbbf7dcb66a364"
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

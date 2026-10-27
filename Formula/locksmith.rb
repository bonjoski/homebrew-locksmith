# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/locksmith-darwin-arm64"
      sha256 "99b6ac6350804eb81bc801250364f7ebcb5e58c163219769c0ae46b808c7b51a"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/summon-locksmith-darwin-arm64"
        sha256 "cd722430b8150b4f0d9c55079c7cce6f0d133935d008bb83a3856c6cccfb1eaa"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/git-credential-locksmith-darwin-arm64"
        sha256 "984a1a38f0cea32625ef042a0ced570825ed1947e30e459c7365723b9112cdbb"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/locksmith-darwin-amd64"
      sha256 "df38ab3cd43ef8c494e7ae0b9d819148254fea4bd5dc4680a772f8de08c12988"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/summon-locksmith-darwin-amd64"
        sha256 "15dc7a84ddb89c5e55844a3074c12df5769750f652a61bdabae9a260ec27c630"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.10.0/git-credential-locksmith-darwin-amd64"
        sha256 "ea760f46d85a48c01dbd66bb0162041d1081625b516b305f0f574f2a8791e5bd"
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

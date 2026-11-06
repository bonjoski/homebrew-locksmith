# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/locksmith-darwin-arm64"
      sha256 "0c29971e5b1c2c415598d9dd424c45bd955240e389b5911ec1ad15b8e3ecffa3"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/summon-locksmith-darwin-arm64"
        sha256 "c918818656baf8a0afd9f085ac541f6a003bf773ba56129ac622b798e744a39f"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/git-credential-locksmith-darwin-arm64"
        sha256 "65ec71434052850ceacbd6eb903bafffd78c7a800b3297e8c6c9143df72f361e"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/locksmith-cockpit-darwin-arm64"
        sha256 "7b54328d187674ab8d0c59426067effd8fa0541644465c712cc075ba31f0ad55"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/locksmith-darwin-amd64"
      sha256 "22d8f389a867bfb73b393733f6085c8db27fba18da9f9387854ece7587ea0c60"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/summon-locksmith-darwin-amd64"
        sha256 "06634adecd85c4643d2b5aeec53dac7f3d2c4ec2b7fdecc954ed7e97c6dc88e4"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/git-credential-locksmith-darwin-amd64"
        sha256 "f8000d4ec5f6fc6f887c0dcb556933e772f71f96f3a6327a367f5028ed6ed85c"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.7/locksmith-cockpit-darwin-amd64"
        sha256 "e90c665a0ff72266653176e14218922e8691d073d9d5008ef330b355f58f4317"
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

# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-darwin-arm64"
      sha256 "b6f81d84d4b9d38f13c25e4cf5bfa133b0790f5eede052394db7cdc9d530dbad"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/summon-locksmith-darwin-arm64"
        sha256 "b97626781e28af29eb6b6c2a0feea4bb5628c0f0cee7fe81bd3aa9618e409d0b"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/git-credential-locksmith-darwin-arm64"
        sha256 "90cbc05987045e70fc1da2f7c6d463b0e1f0e89388576e92f31d13c15e4c2540"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-cockpit-darwin-arm64"
        sha256 "63ca8f8304693757aac1b72bcd333636425359650c4d2b1421a8bcac90392d30"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-darwin-amd64"
      sha256 "32657be4ba6bea8c9661da1f0c6de54c90832591697d397879e5102fdd0587c5"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/summon-locksmith-darwin-amd64"
        sha256 "5c5a17102e68d48b2192358f8060cdeb24dce12859d6fe6c43a2fb85a5c03673"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/git-credential-locksmith-darwin-amd64"
        sha256 "cf44639d338eb10a4019ea2197806796df2550f3ad09f2e4970c5ef99ad6da5c"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-cockpit-darwin-amd64"
        sha256 "5adb6fbf745d25c62a5a6d520bbe4ccd0a99ba81707341ef46b9cf545c7a7b4d"
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
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-linux-arm64"
      sha256 "1762a60a3735252ad023da796c104c1f9676ade1e2aa2ecf200b0959fad1d5cd"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/git-credential-locksmith-linux-arm64"
        sha256 "dc492e98df3021435908549d0526947484d259daf7f537902cf7f5c5aec5a876"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/locksmith-linux-amd64"
      sha256 "b40e13102256a3b84c1ce9dfbe30436b3745097e9b5bc24778d58bfcd29b8200"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.9/git-credential-locksmith-linux-amd64"
        sha256 "006c8d686213cf4bdbcecd0327734d29f37c10890325beb94fa5cb4eceb94ed7"
      end

      def install
        bin.install "locksmith-linux-amd64" => "locksmith"
        resource("git-credential-linux-amd64").stage do
          bin.install "git-credential-locksmith-linux-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_predicate bin/"git-credential-locksmith", :exist?
    assert_predicate bin/"locksmith-cockpit", :exist? if OS.mac?
  end
end

# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.4.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.4.2/locksmith-darwin-arm64"
      sha256 "5ef701319a2641333f2d7fdff4f0ea9ad197748f3cdb197fd6747e5a9fe51b80"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.4.2/summon-locksmith-darwin-arm64"
        sha256 "ad5990babe1d0a5e9ee5b6e7076193c776ccff5de041936dfaadb419559c9b8c"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.4.2/locksmith-darwin-amd64"
      sha256 "f52b05c39f5ddf89ff4ba8232071ef52a5e3d876381d42e4417a9333e06c67f2"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.4.2/summon-locksmith-darwin-amd64"
        sha256 "03438c29f228de45f8d82ec4a80b981b11ae72918018b20f5b20853411d34976"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/summon-locksmith --version 2>&1")
  end
end

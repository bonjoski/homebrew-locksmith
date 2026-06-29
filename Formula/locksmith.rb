# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.1/locksmith-darwin-arm64"
      sha256 "e2784ebb898323b8ea97929d67e96b1355f7a122aa5c262bcd7525d5950364bb"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.1/summon-locksmith-darwin-arm64"
        sha256 "98ada3d5a1be5d40879299f1362553cd27b2e60dab3be48c9e8fd34144133346"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.1/locksmith-darwin-amd64"
      sha256 "0102058d43589112aa7f02fde69c9f9325a207c2289532a8f779273e65e140d5"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.1/summon-locksmith-darwin-amd64"
        sha256 "b4d95919c1c6ed3eaae535c8b9e50907723c11bff10a6e0dc46c3871deafa2c4"
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

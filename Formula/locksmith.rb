# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.0/locksmith-darwin-arm64"
      sha256 "835b89fa8f3d6ac791d133f9c9964cad5b40f3adf0eb626c09c8ae0db5a23996"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.0/summon-locksmith-darwin-arm64"
        sha256 "b69b283ceab5e0cfbcdca6b2728742080255fb3f082c46bf74d2dc7a02dd472c"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.0/locksmith-darwin-amd64"
      sha256 "9fccb4285d237af1791322fc1f977492b40888d1ac5ff241ff319f3e88ab7c9c"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.0/summon-locksmith-darwin-amd64"
        sha256 "dcf48c12f633783ba121922c924c9ae73ab59511095acaa74a16ae0c8460329a"
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

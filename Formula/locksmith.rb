# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.4.0/locksmith-darwin-arm64"
      sha256 "b6c6d8fedad566b2c44d5995a2144a0a3c01df6299f7adc60a53b002b38b04e4"

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.4.0/locksmith-darwin-amd64"
      sha256 "b6249baa6aeecf398c5caa9eb2730b7b46709795fd4c008eb6ba5b2d30618b35"

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
  end
end

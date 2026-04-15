# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.3.0/locksmith-darwin-arm64"
      sha256 "a373385f8e5adc2c01643b584416215f7d986a8528c3c04546d5fbb32fa35b3c"

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.3.0/locksmith-darwin-amd64"
      sha256 "b9fb3b901d8d4f513638fb974f98eccf50d37c36f0127b91a2761f9dcbcac073"

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
  end
end

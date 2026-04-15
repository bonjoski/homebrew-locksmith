# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.3.0/locksmith-darwin-arm64"
      sha256 "12239726eb29a8876ada3ac24fd5c201b41b79b20013ed5c83d417a2addb409e"

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.3.0/locksmith-darwin-amd64"
      sha256 "b7a790eac921f4a2acc45b19d44babfd3fbb1af61cf71d99172b047325f19468"

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
  end
end

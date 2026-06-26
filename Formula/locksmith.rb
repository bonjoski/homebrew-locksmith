# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.5.0/locksmith-darwin-arm64"
      sha256 "6c7071735953c202b8c3ef798342ce6c5e0ac802a249ffca4fa5b033218d8696"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.5.0/summon-locksmith-darwin-arm64"
        sha256 "2a1ef242c4f913916c5b3539d138f6a138c3f09201053116751c86266a8b1f20"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.5.0/locksmith-darwin-amd64"
      sha256 "26e50e89567d02438b45a330e68c9be79d5fbadb3cd1d48dea4ff4d81247c993"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.5.0/summon-locksmith-darwin-amd64"
        sha256 "a1508c8516412840d2609322c22ed8ec39afbe6a9fe55d61f12b3efecc0fd837"
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

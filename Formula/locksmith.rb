# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.2/locksmith-darwin-arm64"
      sha256 "7402259cabc8019b84db64d7ede0dd04a1262752f5ac2d3327e1c230573a54f4"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.2/summon-locksmith-darwin-arm64"
        sha256 "d5b20943b86f60fdc48c2b00db83bb01fa91cb6282f9f715a95926af9a66f604"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.2/locksmith-darwin-amd64"
      sha256 "6493385be38e9f072086d9a9f71261cea785f3f67f8d69ef5a4723a77cda0b85"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.2/summon-locksmith-darwin-amd64"
        sha256 "8bd688d6fd6524147f03f6829d68d2a825fad43d2e0c7f64da243973f59e695c"
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

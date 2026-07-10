# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.6.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.3/locksmith-darwin-arm64"
      sha256 "71446ad4c3beadf50ec9389ba971b4d3107fa7deaccbfe98e70648e93ee478d6"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.3/summon-locksmith-darwin-arm64"
        sha256 "0cca66988c71a504158cc45ca0ada590fbcef95797753d67834424fab5965dc1"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.6.3/locksmith-darwin-amd64"
      sha256 "bd16ab5971937883944097e1356aa7beb53db60f895cc24ccf60afa31edadfdf"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.6.3/summon-locksmith-darwin-amd64"
        sha256 "53ffd6a92ed017f01c70a678e8228697f368671cdc2bf2e8b707f764f60f637c"
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

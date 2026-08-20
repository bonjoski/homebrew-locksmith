# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/locksmith-darwin-arm64"
      sha256 "48450599dfe9e441c27f9cc830f6ac0916f816ef9825e8336fb46b0bc257dadb"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/summon-locksmith-darwin-arm64"
        sha256 "0a3c5d27c850d1d04724903a78451bb10cfcb88976df5f3d5477336b0c852593"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/git-credential-locksmith-darwin-arm64"
        sha256 "9915ccf31d36241ec6cc5b824f39ef364071cbc53801ebdb9ed8ed3443026b41"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
        resource("git-credential-arm64").stage do
          bin.install "git-credential-locksmith-darwin-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/locksmith-darwin-amd64"
      sha256 "9e08c0be0fdef0acc1d10545c44113638b8b42ef52ef9eb0277bcaf4012e81a5"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/summon-locksmith-darwin-amd64"
        sha256 "5f739dd9a2d783b0f02c5bf925649978ffdf63a1e17d410556eae6b1dab704a9"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.10/git-credential-locksmith-darwin-amd64"
        sha256 "45f262c8f88f1b5a0387eb259e97375bc8862c647994101d15332bc57208d033"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
        resource("git-credential-amd64").stage do
          bin.install "git-credential-locksmith-darwin-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/summon-locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/git-credential-locksmith --version 2>&1")
  end
end

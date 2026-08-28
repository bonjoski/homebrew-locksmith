# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/locksmith-darwin-arm64"
      sha256 "45ca24d083c05ba7ba21502ac0ec2a77a9cf3d3d60c0484afef517ec98a7baa0"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/summon-locksmith-darwin-arm64"
        sha256 "07866507f190bb64f444ea3d1f05ab34baef7d58d7342939a9c83b65cae91eee"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/git-credential-locksmith-darwin-arm64"
        sha256 "7d246e536cdad6df431f9919df5c44bb38d9cb1f477a5e79e90ab05620f641b2"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/locksmith-darwin-amd64"
      sha256 "c260effbca76ca6d4409c3978eeac9ec119f9d39166f2c8188b49630eb82f170"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/summon-locksmith-darwin-amd64"
        sha256 "28993bdfd137579fdf8c2237688998c3ffd73c46e3a7205a4336937e3cb1e4f0"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.12/git-credential-locksmith-darwin-amd64"
        sha256 "d82ff360f3d6a94ccb995df03c79beaae01a5b6eac649b005788f2838734f888"
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

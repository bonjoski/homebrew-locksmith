# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/locksmith-darwin-arm64"
      sha256 "da63e41b51bfd8642a4561be8206e9b968aed0f7894e6ac6a9a164add76515d2"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/summon-locksmith-darwin-arm64"
        sha256 "9ea15dc486efbac07e63b031e7b70f57663a6a0540685de211fa9a6739e81c1b"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/git-credential-locksmith-darwin-arm64"
        sha256 "a446bb57e9b5d4cea136dd1dee3197899acdc28ce31d80d3d3fff8b117e38024"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/locksmith-darwin-amd64"
      sha256 "7bd136f1b405973e979e0d827dfe46096beefe4712f60e3c345173ad9c6cb576"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/summon-locksmith-darwin-amd64"
        sha256 "82de1dfaf2cdc9db3953fc9e7d65007b2cc9f51419e91aea4cf301f80e28a4a5"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.14/git-credential-locksmith-darwin-amd64"
        sha256 "d6ea593503681cda2d2a73ddb0f62abfa847f1915d9a4bb0c7857c04dd4f0d82"
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

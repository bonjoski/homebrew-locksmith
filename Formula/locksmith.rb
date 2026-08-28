# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/locksmith-darwin-arm64"
      sha256 "b0657ae26d59ca3f8ebe8ae30b80a4f6b1ff5736149325d135542906ed11d768"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/summon-locksmith-darwin-arm64"
        sha256 "30bd68023270b42fef15d5729e540d324eb13ba65ab39fe287e5fd3d62502d10"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/git-credential-locksmith-darwin-arm64"
        sha256 "6e63f264e09b09ff4d955168f78bc7bdc08d1f9b0d6b5ea36e6e0775e594e321"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/locksmith-darwin-amd64"
      sha256 "07a4452ca2f3c74af2c83ac699f7d48ccfb12668e7a4e1dc0bb1e35febb96699"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/summon-locksmith-darwin-amd64"
        sha256 "1cadc529b0013b126c8649d1019a79a41693f46a2c1f266e15a34917ad672085"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.11/git-credential-locksmith-darwin-amd64"
        sha256 "0e3622eb94fd5b03fc106808b60db18cf457e34c3a5b333f87c75af95731cfd5"
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

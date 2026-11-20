# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.3.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-darwin-arm64"
      sha256 "6feb66caa92f5926d80be26ba8d222f467ef38b5e9de7a4b0cd4f5bc4dc91f85"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/summon-locksmith-darwin-arm64"
        sha256 "b08c66ae804b16e19544f2ba813974e1cbe8b5166e08bd8a6b75f1a5a2bd1603"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/git-credential-locksmith-darwin-arm64"
        sha256 "c27f6880b9d50f96285fe0bca54d664396d821caa90d98efa9fa02bcc8bb4714"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-cockpit-darwin-arm64"
        sha256 "b2bb84cb905a1d71d3a9905fb1c2d20922e4f29eb23fed64146a26b5487f7ec8"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
        resource("git-credential-arm64").stage do
          bin.install "git-credential-locksmith-darwin-arm64" => "git-credential-locksmith"
        end
        resource("cockpit-arm64").stage do
          bin.install "locksmith-cockpit-darwin-arm64" => "locksmith-cockpit"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-darwin-amd64"
      sha256 "c0801bd0b41639f3e8cd48484eab4e53acb9cf8e30ca0f4d6cc973a9d9e2f56f"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/summon-locksmith-darwin-amd64"
        sha256 "9cba2a2f6106df2e97509f9d35231787c10db12278f9cca0e6147d661ef15fcd"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/git-credential-locksmith-darwin-amd64"
        sha256 "e9cbc54d198cefb318f6440231eab29c1300f9fb5722fa73398cee898c07a7f9"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-cockpit-darwin-amd64"
        sha256 "5a09568d5cde3166849d73821b4119cb3d9f3e0a29cec0c694da718f8351d764"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
        resource("git-credential-amd64").stage do
          bin.install "git-credential-locksmith-darwin-amd64" => "git-credential-locksmith"
        end
        resource("cockpit-amd64").stage do
          bin.install "locksmith-cockpit-darwin-amd64" => "locksmith-cockpit"
        end
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-linux-arm64"
      sha256 "2249221aa441cdb419af25bb9ae15e5557c7c59a519e36e3c314fc6fb7f68ae5"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/git-credential-locksmith-linux-arm64"
        sha256 "23c046800788cc6c8f8e214a40406b13fc7b7a2d306acbe20e09dccc82521148"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/locksmith-linux-amd64"
      sha256 "2001908e4b516d079eece60a4e494bae18d319654e9c67649c66efc7e13c7923"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.3/git-credential-locksmith-linux-amd64"
        sha256 "452c28dc4d160bc1ac9008b4d0c5c7cb84a01a4b73e753d835acb5e8f91a20c2"
      end

      def install
        bin.install "locksmith-linux-amd64" => "locksmith"
        resource("git-credential-linux-amd64").stage do
          bin.install "git-credential-locksmith-linux-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_predicate bin/"git-credential-locksmith", :exist?
    assert_predicate bin/"locksmith-cockpit", :exist? if OS.mac?
  end
end

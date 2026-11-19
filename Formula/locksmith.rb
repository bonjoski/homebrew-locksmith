# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-darwin-arm64"
      sha256 "cfe1029d1b308ff170f4b2c1300b904dc790e63e6352bde6eacdaad2198064cf"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/summon-locksmith-darwin-arm64"
        sha256 "afb3139fe9a0f106dadbaddc7941b3f85310f2d4d4fe884b70c762c983361883"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/git-credential-locksmith-darwin-arm64"
        sha256 "e58cabcb28290b634a311cafa328ffb725629940f4367d8d1880815f11d012dc"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-cockpit-darwin-arm64"
        sha256 "7e56444904cbe3074e935512cae1f2e2826422803b07c44765f4dac878e7f557"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-darwin-amd64"
      sha256 "46244ec5163219795284d2aa0ffd22d9f0d53c7cf75d8a4f8dfb6dd46300876c"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/summon-locksmith-darwin-amd64"
        sha256 "8b9fcdd69bf6f357745229cab3e02d85130184ceccf78e47fdb928024b14d928"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/git-credential-locksmith-darwin-amd64"
        sha256 "f29243f4adf909aba3b38f0a00bac189f78992276c5a6a45e6eb43becae16adb"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-cockpit-darwin-amd64"
        sha256 "a257c46f9943c1d8b2ee927978e06a4dcb49962cc7fed53f3374061d0b7e08f3"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-linux-arm64"
      sha256 "e36094ac450c06ffffe8298b16e34888607f02806de5e8afcd70d3d73ed2bb5f"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/git-credential-locksmith-linux-arm64"
        sha256 "d2773d6d112c11cfde6cc3e747978710ae94698ffe6013c1fa6742ded2a2d842"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/locksmith-linux-amd64"
      sha256 "32e5ff7630db2656d7845a1ee96987e52371e63ec40dd37266f63bd0a5db0ea6"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.2/git-credential-locksmith-linux-amd64"
        sha256 "f9fd91a30263e87fc90ff55ba2f64000f4712985e22ef81bacb0c7adab595481"
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

# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-darwin-arm64"
      sha256 "1c4b5a094d227be808d7226b0b26c98b5f2362c654853a5d1c538cf9a4f8f361"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/summon-locksmith-darwin-arm64"
        sha256 "ba924ebcfaa53db07304314cf5ccaa6d23b8e1093fcae1747e16ef75b4397525"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/git-credential-locksmith-darwin-arm64"
        sha256 "0358ffe0b830bdd1984bb40f966524c3cc5fc1ae81915b9f8219ad9fd82c893e"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-cockpit-darwin-arm64"
        sha256 "846c144d7e92abfaaa952f5f57b68c6d849688e569ca56139ab571015d1e7c89"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-darwin-amd64"
      sha256 "e701bf263f6f3391e622c828b69099edda13dc152d24507776fe00e490354d5f"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/summon-locksmith-darwin-amd64"
        sha256 "66605514290d8572a21693fbbda44d719f1ccc2de858951f4c2c417422a69ea7"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/git-credential-locksmith-darwin-amd64"
        sha256 "0cb1e07edcd108a33e7cfc3808460b2b2b9f0623da4c164a7bd01317dbb0f22f"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-cockpit-darwin-amd64"
        sha256 "9458855ba9dbc3efa1e088ca07110b36371621c3f2cb961a7973dcfa7ce42e2c"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-linux-arm64"
      sha256 "f1b34c17def2936a02a7cec38590ba22442ea3359f32d4812692fc725d60cc87"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/git-credential-locksmith-linux-arm64"
        sha256 "e54219001511c67ebcae4748c4a04febae16adfe966941c902fbb1bfb6b23f2c"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/locksmith-linux-amd64"
      sha256 "70f5ef304adea133f58d37efc1a5494957e5cb0813393583e05788cfa2af15a9"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.10/git-credential-locksmith-linux-amd64"
        sha256 "412b61f6496a7667d6a69c07ff1c5a77ba832f1ff5a40351b7aabc3dda8b31f1"
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

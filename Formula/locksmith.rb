# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/locksmith-darwin-arm64"
      sha256 "e9d90c18f78f6d27caad07f83f3b73bdf3e8cb80160f44876daeb722949f63b7"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/summon-locksmith-darwin-arm64"
        sha256 "476ea3f1a21fb58c9100a15fe0f41e16c8a02436664768334108d4b0707cd894"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/git-credential-locksmith-darwin-arm64"
        sha256 "9edb9c27b9017ca5f2cf9a2beca6df51a288043cd092aecf5ce2d933fa62c262"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/locksmith-cockpit-darwin-arm64"
        sha256 "032ccf3da3641a905c3f9a9303ab3354ce4f65b07400e6ee305471c2e8f7a3f3"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/locksmith-darwin-amd64"
      sha256 "19e280db9ff24b080327a8ece3a299586be01a065960a8d8efe4286a056bee62"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/summon-locksmith-darwin-amd64"
        sha256 "9a6fbd91aa1a962e2da29f38d415304626bbd9464c0b4d3f0d780919e88e7486"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/git-credential-locksmith-darwin-amd64"
        sha256 "579c5b7ed9e10cacf3a541deecd0727160fd8ae454fb2bed744a1d35a8e4dc49"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.0.1/locksmith-cockpit-darwin-amd64"
        sha256 "09c979214c72eb2be171186d1d16e511d9c0dba8dc6268ae5169bc506a1e7a8e"
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
    url "https://github.com/bonjoski/locksmith/archive/refs/tags/v2.9.0.tar.gz"
    sha256 "164a576940ee1e3d8fb33e3737a55116cd6c8b6aa096c1acd9bd6400841e157e"

    depends_on "go" => :build

    def install
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/locksmith"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_predicate bin/"locksmith-cockpit", :exist?
  end
end

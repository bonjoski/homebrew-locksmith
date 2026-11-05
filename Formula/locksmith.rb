# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/locksmith-darwin-arm64"
      sha256 "ee878ad1b25a4de92ffb65f551d962d57f057ce1334c29657118f6a91daa1281"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/summon-locksmith-darwin-arm64"
        sha256 "5b001aacda0d65671321c7dc8867cc42276bd59a60f434a48ced72538ec1fe55"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/git-credential-locksmith-darwin-arm64"
        sha256 "65d65e7eca54c25f92c946b615988c9789119d212ee52ecc933c8027c324e409"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/locksmith-cockpit-darwin-arm64"
        sha256 "1a2ae2b348127aca7fabeadc45858511a33094509cc669a4c330811caf6bfc3a"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/locksmith-darwin-amd64"
      sha256 "5ea6ef8e479d208be1163009670bac1ac1f1dc2ab8ca6a3942cb67c376922d15"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/summon-locksmith-darwin-amd64"
        sha256 "e6df7f02ab5d99e9bbab5beffa3cf54012c20841472cf5a8b9a153289a6594b3"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/git-credential-locksmith-darwin-amd64"
        sha256 "560593b110ad3b07f7e1b0816222d1cad2f4e865fb8ba0be9b80de8569e47365"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.4/locksmith-cockpit-darwin-amd64"
        sha256 "9fe98b698372eb9c7cfbd9d526dce83566670fac6b1286882d701d5977a040c0"
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

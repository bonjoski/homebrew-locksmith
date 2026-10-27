# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.9.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/locksmith-darwin-arm64"
      sha256 "d78fe41db533b5ccc5f914d8d11ec00ce893f94550cadd58db601456766bb702"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/summon-locksmith-darwin-arm64"
        sha256 "1d0f07224231e5ff5a64f083cd01b81cf0954e3849012043b36731da7d75e357"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/git-credential-locksmith-darwin-arm64"
        sha256 "2563f1f07f74b977a84610e442d0cd39c1b35cbea4ebc420a70b2cd9e2343479"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/locksmith-darwin-amd64"
      sha256 "ab7aeded291da333cf949151a9b8c8d3fe7e0ba166faff6f2ecb5445a347a1db"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/summon-locksmith-darwin-amd64"
        sha256 "1161e8ce0bfced52e3e41944a777a31d0329809af5c35a3c8ed480cd66c5640c"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.9.1/git-credential-locksmith-darwin-amd64"
        sha256 "e12be26a1e710674337b399a955b51a9097b5edc92e4dbc912d172023750269a"
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
  end
end

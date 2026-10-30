# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/locksmith-darwin-arm64"
      sha256 "a6a786edbcbcb4e6ce88d44b08ee16f46fd3edf5c6ee5566d8bb90d07a955add"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/summon-locksmith-darwin-arm64"
        sha256 "c19ada50380f216349d8645837501ce36544336711396caad644f67ba881b537"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/git-credential-locksmith-darwin-arm64"
        sha256 "0b7b882d67cd4235567adf3eec7ae9068b5cc40272bc064d6fae7471120ebf5d"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/locksmith-cockpit-darwin-arm64"
        sha256 "970724aece0a462cb75b7dd279339c52e59b823cd696fb06ab3617307166771a"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/locksmith-darwin-amd64"
      sha256 "ba8e3b73ab04616198e1d65daed9594f77eb4ba207b5149323204bf2cb60967a"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/summon-locksmith-darwin-amd64"
        sha256 "e6773f7fb029e55219e3a25cba03e87e2b1dd9d3c433afbbfb6e23a759e13ad1"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/git-credential-locksmith-darwin-amd64"
        sha256 "4f7a37b7c12b05eb7229fbe3bb73e8d3cdd96019c36c86f7dbe31c83f08c7288"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.0/locksmith-cockpit-darwin-amd64"
        sha256 "16ffb6aebf39193828df4a1befda204d920db3b59efc25d71f3f4da8f83fc447"
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

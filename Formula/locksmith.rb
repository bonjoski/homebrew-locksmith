# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/locksmith-darwin-arm64"
      sha256 "b5fd2fb3ae97ed1198c1743955a5e5d6ad76d5a1651ae3587ed9102f4f671d59"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/summon-locksmith-darwin-arm64"
        sha256 "bb88f04c91166b6c4f06f29765ed02ef0ead56f9d3c77709e7619fe6b9387e3e"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/git-credential-locksmith-darwin-arm64"
        sha256 "7282ab379a4fb9dee4d2d5a3dec5cfe53c052712987355d6fddb1b56d9864314"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/locksmith-cockpit-darwin-arm64"
        sha256 "62c60b268f89270139ff4fe5931b624cf2d2ae3129ffe699555a72e13a44a904"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/locksmith-darwin-amd64"
      sha256 "929eae97e7bd1f5eb4732cdaf786ec6e40cad9f1b68b984ec618033d3111ad14"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/summon-locksmith-darwin-amd64"
        sha256 "7eb80ec6c63527caa790e8c1f9f978c87172723b6df0bc5d361a47cf8b916676"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/git-credential-locksmith-darwin-amd64"
        sha256 "0eac073c94811fb2c4619951a3970c2f020bbb9690971850f0af6dabdcb6c3ec"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.5/locksmith-cockpit-darwin-amd64"
        sha256 "c0d41fd103de2143094b19195f5a30e72783b23a3f9e20151fa26cfb914d360e"
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

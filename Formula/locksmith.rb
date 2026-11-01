# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/locksmith-darwin-arm64"
      sha256 "c5e6ef84add33bbd0d622cef737bf645bfe3889151baeb67f8ed8bd83855252a"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/summon-locksmith-darwin-arm64"
        sha256 "b09a2d1b11c3e308c9dc6e9915fdbe67498e1769eb7972f8dd544a56ea1997d3"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/git-credential-locksmith-darwin-arm64"
        sha256 "6dd8bb0398a4169ac56839de97b6f64eea39a7c8a8450ee525802af9d9aca8d9"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/locksmith-cockpit-darwin-arm64"
        sha256 "59c70294c504e3317ac634eb05515933dfe370acd137de898493c6ae379cd035"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/locksmith-darwin-amd64"
      sha256 "16eb1569bfc4d2edbf433e9128a175fec1603628528813f81c6ebe1a9be642c8"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/summon-locksmith-darwin-amd64"
        sha256 "fffe07514dfde350ece7d954b21d1f1b4ed4858fa30e621b07cf907d7b085b87"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/git-credential-locksmith-darwin-amd64"
        sha256 "a962d7019486c16381582afc213025d74225e791829a17f2d72a6b8b44a4e617"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.1.1/locksmith-cockpit-darwin-amd64"
        sha256 "44893ae61a37aec4a882e399a4002228f11a7717ba825fd884d83b3365055042"
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

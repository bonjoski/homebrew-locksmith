# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.2.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/locksmith-darwin-arm64"
      sha256 "9e916a83fa323eb3a83dbfd2f0460290a335c5eca13f6d4782853076daa2e1c4"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/summon-locksmith-darwin-arm64"
        sha256 "c88d7c312856c48d37684ebe02f9c999b2cd734011ab9b81292074b5be124327"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/git-credential-locksmith-darwin-arm64"
        sha256 "cdba920b6a69629773f79a780671ee40193a3dc9f35a952e179ee6644da7d6b4"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/locksmith-cockpit-darwin-arm64"
        sha256 "daa5b246c6821ba76a66e5381398c0ba2dedc12c45c6a465b129279186bf5b4f"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/locksmith-darwin-amd64"
      sha256 "191bde9bd82f3f733f0de59278ba1e5b0bc18be90184d86a6f55b64ee2731b65"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/summon-locksmith-darwin-amd64"
        sha256 "a42384a1fee18d4b3ac034fe643424b35c14e49e9573ccc52316a4a397793591"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/git-credential-locksmith-darwin-amd64"
        sha256 "4be6c10dbb704e8aa28dc868fa23f98ad4df4d6b3caf6020627699f5de4cb070"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.2.6/locksmith-cockpit-darwin-amd64"
        sha256 "5ba5a9b09a609895b70595cf16667d73541cb8d91c2339c3cb7be2b44745fbce"
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

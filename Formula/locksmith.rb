# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-darwin-arm64"
      sha256 "383afab4eb3cd07077405b882ad1418fe5f7f2e1e3a1461e419efb99b70cda5e"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/summon-locksmith-darwin-arm64"
        sha256 "5369f095b1608a1a2279f5c09a14960b54b1bf46495ea166849b7fa2214ff706"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/git-credential-locksmith-darwin-arm64"
        sha256 "f1a705248e7b6d404b41261fca607a2fd2779c15c1042ed891463aae5149e56f"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-cockpit-darwin-arm64"
        sha256 "aef000b48972fd039db03592544394e2f342b616263dedb4e879f4a4d687fd75"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-darwin-amd64"
      sha256 "6b651ec0945c12d46f35300671c72e3bc80186e2c98c24016e8d942ff170bfb0"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/summon-locksmith-darwin-amd64"
        sha256 "9e9d8db687694b9b415e025420c3f9d30639f267e5fcfbbd727a13ff0feb6d53"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/git-credential-locksmith-darwin-amd64"
        sha256 "ea86577331d8da8166c8bcb52c37cf8633d76968a04ad8542249b815c40e47a6"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-cockpit-darwin-amd64"
        sha256 "661a78f391fa1bcb5c1a202f51fb2186d7911832f997a8c5966987088f336ffe"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-linux-arm64"
      sha256 "55c48a531e61ee4b29530108188d318b280b8851efd3907ed220f172e12229c9"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/git-credential-locksmith-linux-arm64"
        sha256 "c4db1a9cd15d138e19a728677278aa49724319e992789435aebb188e54487d33"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/locksmith-linux-amd64"
      sha256 "8439a7f7b6784e5495fd84e23fed5da5b07e36f3176dff2f78bda68b7b1067c0"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.3.1/git-credential-locksmith-linux-amd64"
        sha256 "f4d58a9172bc0708b6ac00cfbbdf7c6ed16d646461f6d7f278290481e91d6e40"
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

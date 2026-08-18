# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "2.7.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/locksmith-darwin-arm64"
      sha256 "458eb49256f98ffcac12b82a1590af04ae5ef5cf0fd0e81a78e78905be3db00a"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/summon-locksmith-darwin-arm64"
        sha256 "7aa1761d84ba13b11e235a48949758c06df01b4efaf3efbd450d3a965608fc20"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/git-credential-locksmith-darwin-arm64"
        sha256 "563c0ff0ce89a139441167f611b4da796591c9d519844e460eef83a9be75757d"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/locksmith-darwin-amd64"
      sha256 "3e2888aa4fac1c20ae0caaf4afad0e03bb311aae5948f8b55b0222d9a81c6574"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/summon-locksmith-darwin-amd64"
        sha256 "a1eccb4317f938e518d2ed2710b45c79ec84148195f069c3d956e60fcac9aed6"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v2.7.9/git-credential-locksmith-darwin-amd64"
        sha256 "f7fcee34c4e0f18f69bbab763d9503b00fd5112caef0d4ad10b4d8bc09129dd4"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/summon-locksmith --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/git-credential-locksmith --version 2>&1")
  end
end

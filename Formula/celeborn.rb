# Homebrew formula for the standalone Celeborn binary.
#
# Lives in the tap repo `cloud-dancer-labs/homebrew-celeborn` as `Formula/celeborn.rb`. Then:
#
#     brew install cloud-dancer-labs/celeborn/celeborn
#
# Since 0.3.0 the asset is the compiled, all-rights-reserved tarball on the binaries-only repo
# cloud-dancer-labs/celeborn-releases (CELE-t650/t651): celeborn-<ver>-macos-arm64.tar.gz containing
# `celeborn` + LICENSE + README. Per release: bump `version` and paste the tarball's sha256 from the
# release's SHA256SUMS manifest. Cask vs. formula: a single-binary CLI is a formula.
#
# Apple Silicon only for now — the Intel-mac (x86_64) leg is queue-starved in CI (see
# .github/workflows/release.yml). Intel-mac users install via `pip install celeborn-code` once an
# x86_64 tarball ships. Re-add the on_intel block when celeborn-<ver>-macos-x86_64.tar.gz publishes.

class Celeborn < Formula
  desc "Long-term context substrate for coding agents (CLI)"
  homepage "https://github.com/cloud-dancer-labs/celeborn-code"
  version "0.3.0"
  # The tarball is the compiled client — all rights reserved (LICENSE ships inside it).
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/cloud-dancer-labs/celeborn-releases/releases/download/v#{version}/celeborn-#{version}-macos-arm64.tar.gz"
      sha256 "185abf540e89267ce4152fd5bb37f142c57b0f11119f8329bdbe6560114e7140"
    end
  end

  def install
    # Homebrew unpacks the tarball and enters its single top-level dir; the binary is `celeborn`.
    bin.install "celeborn"
    bin.install_symlink bin/"celeborn" => "cel"
  end

  test do
    assert_match(/celeborn/i, shell_output("#{bin}/celeborn version"))
  end
end

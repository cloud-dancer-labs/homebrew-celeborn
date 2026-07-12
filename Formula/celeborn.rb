# Homebrew formula for the standalone Celeborn binary.
#
# Lives in the tap repo `cloud-dancer-labs/homebrew-celeborn` as `Formula/celeborn.rb`. Then:
#
#     brew install cloud-dancer-labs/celeborn/celeborn
#
# The release workflow builds per-arch binaries and prints their sha256 (the *.sha256 sidecars);
# bump `version`, the URLs, and the `sha256` value on each release (the bump can be automated
# from the Release assets). Cask vs. formula: a single-binary CLI is a formula.
#
# Apple Silicon only for now — the Intel-mac (x86_64) binary is deferred until a macos-13 CI runner
# is available (see .github/workflows/release.yml). Intel-mac users install via `uv tool install`
# or the curl|sh path. Re-add the on_intel block when celeborn-macos-x86_64 ships.

class Celeborn < Formula
  desc "Long-term context substrate for coding agents (CLI)"
  homepage "https://github.com/cloud-dancer-labs/celeborn-code"
  version "0.2.1"
  license "BUSL-1.1" # source-available — © Cloud Dancer; distributed by Thot Technologies LLC

  on_macos do
    on_arm do
      url "https://github.com/cloud-dancer-labs/celeborn-code/releases/download/v#{version}/celeborn-macos-arm64"
      sha256 "5fc31bd4fcb99fa08950532f52bf9dfc4bec7f283f6dd061d2ff024f3e96b9c7"
    end
  end

  def install
    # The downloaded asset is the bare binary (named per-arch); install it as `celeborn` + `cel`.
    bin.install Dir["*"].first => "celeborn"
    bin.install_symlink bin/"celeborn" => "cel"
  end

  test do
    assert_match(/celeborn/i, shell_output("#{bin}/celeborn version"))
  end
end

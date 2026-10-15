cask "fynetune" do
  version "0.13.0"

  on_arm do
    sha256 "8ff78d3549e3c9bfb7c89eed599d42deb2a89c95f8332b76ee6b6782a85ed544"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "e387f0c3859103ba6c73787d1c59a650077acef3e49eb7fadd3110be8e12a497"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_amd64.dmg"
  end

  name "FyneTune"
  desc "Internet radio player"
  homepage "https://github.com/lucor/fynetune"

  livecheck do
    url "https://github.com/lucor/fynetune"
    strategy :github_latest
  end

  depends_on :macos

  app "FyneTune.app"
end

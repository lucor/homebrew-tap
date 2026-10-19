cask "fynetune" do
  version "0.15.0"

  on_arm do
    sha256 "77fc5eac29040fda98321826f2420c9f46652b1ab485ba95ae3c6255d0f5eabe"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "5f1d7dce5a912120c427032d2b73a8e974433ad2563ebb5ce6e14154cb70208c"

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

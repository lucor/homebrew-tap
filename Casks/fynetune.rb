cask "fynetune" do
  version "0.17.0"

  on_arm do
    sha256 "2f38a6abd8206df49c0be7509222946792591be8460301c5ea6f75cbfdf46864"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "445b9d0e4d07edc8cd98a07c63bd864fcf614dc3a30e54fb33c52d67906bee77"

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

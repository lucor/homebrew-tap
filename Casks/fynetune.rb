cask "fynetune" do
  version "0.16.0"

  on_arm do
    sha256 "06e8adc6800dea8315cbea440d496fa8e07b7eca874dcc9d14120fa2c5e04782"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "ad7181c9790c7c9b87357269ba43da99304534ce559351af88f0ede6c2b5178d"

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

cask "fynetune" do
  version "0.14.0"

  on_arm do
    sha256 "673fb9c2b7eb8c52f3b720049ef81d415fad785d44d7157c51aadac6d3ff5820"

    url "https://github.com/lucor/fynetune/releases/download/v#{version}/FyneTune_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "1bb8fa4d226e134cfef4e46aa268b9938a9b95a30eb5ddc4aeb6a9345adf4817"

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

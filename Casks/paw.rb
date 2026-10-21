cask "paw" do
  version "0.28.1"

  on_arm do
    sha256 "d800fde9258455e97f05600a6caca4dae56e718907dff1f7e7f71da8f35a5fba"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "b3c7fe045af9bff246bb3ccee16ebab2660d27bb17d0fab344808f7f54312f38"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_amd64.dmg"
  end

  name "Paw"
  desc "Open source password manager"
  homepage "https://paw.pm/"

  livecheck do
    url "https://github.com/lucor/paw"
    strategy :github_latest
  end

  depends_on :macos

  app "Paw.app"
end

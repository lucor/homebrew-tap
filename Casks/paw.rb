cask "paw" do
  version "0.31.0"

  on_arm do
    sha256 "0870b9dd305f96b66e91f008fe68f26a156619c7ae1dd3a17383afb346a49ae7"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "5c6f48e6cd536c4a261c25d433eecc0b6cdeb6ce4159376e35a6c4b6957eed95"

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

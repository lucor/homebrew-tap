cask "paw" do
  version "0.29.0"

  on_arm do
    sha256 "c98aea013d45a695129adf9dcd7e929bb40b2a628903efa57be28c09d44349f4"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "a94c1392c581f5dbaf3916dc7ac0d063522ed40997bdee4bc70729d2589407b1"

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

cask "paw" do
  version "0.28.0"

  on_arm do
    sha256 "8da9f19559983ecb315f684a525ec39bcb5fb05f0fb3c7cc5c6f21004dd630af"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "bc87e1682d981a4724355267818b84f682bd2a20468400ecfee3ff7fcbef4c34"

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

cask "paw" do
  version "0.30.0"

  on_arm do
    sha256 "05e014c6723e109a24406887d9e76355605189f09f9f7b7faf65de2b337e18bd"

    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_arm64.dmg"
  end
  on_intel do
    sha256 "88860e7d04054fe3864156076a5a30f035e4ebccd0d2eee7b2bafc6a12b9f908"

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

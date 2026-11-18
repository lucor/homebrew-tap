cask "paw" do
  arch arm: "arm64", intel: "amd64"

  version "0.33.0"
  sha256 arm:          "70e5a1f22550b74156a54554b9270fc74cf0893476017fab849f883580a87780",
         intel:        "097cfe953c39cc1803f575990a24b81599955342b4a2a443e8c9ff701073710e",
         arm64_linux:  "6ee8eb6d47c2a62bc9bb0e98dd7e4948c0a0259c38a8fba94c0f898c6a90a1a9",
         x86_64_linux: "469c57e73cf1f84ec7f4744e03b97d179a7e7a4963396ba1f7fdf39f49dc5fed"

  on_macos do
    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_darwin_#{arch}.dmg"

    app "Paw.app"
  end
  on_linux do
    url "https://github.com/lucor/paw/releases/download/v#{version}/Paw_#{version}_linux_#{arch}.tar.xz"

    binary "paw/usr/local/bin/paw"
    artifact "paw/usr/local/share/applications/dev.lucor.paw.desktop",
             target: "#{Dir.home}/.local/share/applications/dev.lucor.paw.desktop"
    artifact "paw/usr/local/share/pixmaps/dev.lucor.paw.png",
             target: "#{Dir.home}/.local/share/icons/hicolor/512x512/apps/dev.lucor.paw.png"

    caveats do
      path_environment_variable "#{HOMEBREW_PREFIX}/bin"
    end
  end

  name "Paw"
  desc "Open source password manager"
  homepage "https://paw.pm/"

  livecheck do
    url "https://github.com/lucor/paw"
    strategy :github_latest
  end
end

cask "paw" do
  arch arm: "arm64", intel: "amd64"

  version "0.31.0"
  sha256 arm:          "0870b9dd305f96b66e91f008fe68f26a156619c7ae1dd3a17383afb346a49ae7",
         intel:        "5c6f48e6cd536c4a261c25d433eecc0b6cdeb6ce4159376e35a6c4b6957eed95",
         arm64_linux:  "ac05118477d784129a271150de75fc4c32b8f4f06c868e1b9bf09e841a556b2c",
         x86_64_linux: "1a3d9e09e7e7c9410e6b0a28555d9effb78e10a510e0c67c3b39f02e855bd67f"

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

cask "paw" do
  arch arm: "arm64", intel: "amd64"

  version "0.32.0"
  sha256 arm:          "aad2966235871bbf7b17df92bb8ae95d5dd9d1859c809d36b357ab7d3e5863d7",
         intel:        "f551e068452fb52957a0ba72842c441449dba9f0e5239a7c8e1abfeb0a201ba7",
         arm64_linux:  "1d162b9c3d2fff9aea69c37eab722afceed4f786d5133695e5b0713bb43eb5ac",
         x86_64_linux: "40088a68a33f8e6e62cc3d34f4c8a98e41f3130d324510a411a469ce5e02e12f"

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

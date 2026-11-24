cask "paw" do
  arch arm: "arm64", intel: "amd64"

  version "0.34.0"
  sha256 arm:          "9c3eab61ca4ef4f08085d6fac5a51f87113a3dd3b079a945e52af9aa06cca5df",
         intel:        "338fe838ddfaad37e9548ce9f81b543965c2e12d9d029dc9749423c8b9343b03",
         arm64_linux:  "7da5b65ffc0e3ea93c4ee38800b99cb68a6d37b5da471b255fbb98fdbe7bd306",
         x86_64_linux: "8be118d0f22cfed73083c55165dd2bf28e0173e70671dae2588f7050b81d666c"

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

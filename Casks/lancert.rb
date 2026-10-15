cask "lancert" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.4.0"
  sha256 arm:          "ed9f5a65654783d45889a002e2d494bd95986b31b336cfd38cf94369c503ca29",
         intel:        "fade5f7e6402607997ec37113de79b3e749e4b3ebcf28c7a4f9e5a4e463c328b",
         arm64_linux:  "b3f011f16020b90e22a03c35fcf65fd2a030fe3a61178b5bfd54e49e844541a9",
         x86_64_linux: "2748f57b99967763819e3bacbe3a6f56e532a4afcebb04bc18416eea3d0f7cf1"

  on_macos do
    postflight_steps do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/lancert"]
    end
  end

  url "https://github.com/lucor/lancert-cli/releases/download/v#{version}/lancert_#{version}_#{os}_#{arch}.tar.gz"
  name "Lancert"
  desc "Local HTTPS certificates for private IP addresses"
  homepage "https://lancert.dev/"

  livecheck do
    url "https://github.com/lucor/lancert-cli"
    strategy :github_latest
  end

  binary "lancert"
end

cask "lancert" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.6.0"
  sha256 arm:          "18582720bdacb8b3240a6fa5ced3a848c6ed95b49722e8b7a335ea5932aaf7ca",
         intel:        "f75c6a1133dbc2cb5e8d1618e921e50f5637374e1f60311274ff074051d6c7eb",
         arm64_linux:  "83bc5f6ad99767d3b7ec29519ebf350e42cf037bb04bc75af630558034f624dd",
         x86_64_linux: "ac5aa2bd642ebdcaa649991ca091627ded01104523c0b113e25847a272331f94"

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

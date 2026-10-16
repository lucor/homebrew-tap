cask "lancert" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.5.0"
  sha256 arm:          "416c833fac9694493ca02ef2efd69f1246ce46c62b83e90b786d405f6e554517",
         intel:        "da7b792dbde90600fcc783d6d0d3b8769e43c6935f628312067bb88ef924fab9",
         arm64_linux:  "ac378d534eec1829cb8a7e2f5c2806efb925b907e485b5abb74dd7db71f0f76f",
         x86_64_linux: "2963d69fdc2630e5fe820295078ab9f27103ec317cd34b50ee2293b488b95b9c"

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

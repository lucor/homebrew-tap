# Run with `brew ruby tests/platforms.rb` to use Homebrew's real cask loader.
require "cask/cask_loader"

root = Pathname.new(__dir__).parent

{ sequoia: "darwin", linux: "linux" }.each do |os, artifact_os|
  { arm: "arm64", intel: "amd64" }.each do |arch, artifact_arch|
    Homebrew::SimulateSystem.with(os: os, arch: arch) do
      cask = Cask::CaskLoader::FromContentLoader.new((root/"Casks/lancert.rb").read).load(config: nil)
      raise "Lancert must support #{os}/#{arch}" unless cask.valid_platform?

      expected = "lancert_#{cask.version}_#{artifact_os}_#{artifact_arch}.tar.gz"
      raise "Wrong download for #{os}/#{arch}: #{cask.url}" unless cask.url.to_s.end_with?(expected)
      raise "Missing checksum for #{os}/#{arch}" unless cask.sha256.to_s.match?(/\A[0-9a-f]{64}\z/)

      flights = cask.artifacts.grep(Cask::Artifact::PostflightSteps)
      raise "macOS quarantine hook must never run on Linux" if os == :linux && !flights.empty?
      raise "Missing macOS quarantine hook" if os == :sequoia && flights.empty?

      %w[paw fynetune].each do |token|
        desktop = Cask::CaskLoader::FromContentLoader.new((root/"Casks/#{token}.rb").read).load(config: nil)
        raise "Wrong platform support for #{token}" unless desktop.valid_platform? == (os == :sequoia)
      end
    end
  end
end

%w[lancert paw fynetune].each do |token|
  cask = Cask::CaskLoader::FromContentLoader.new((root/"Casks/#{token}.rb").read).load(config: nil)
  platforms = cask.to_hash_with_variations.fetch("supported_platforms").map(&:to_s)
  %w[x86_64_linux arm64_linux].each do |platform|
    raise "Wrong CI platform metadata for #{token}/#{platform}" unless platforms.include?(platform) == (token == "lancert")
  end
end

puts "Cask platform tests passed"

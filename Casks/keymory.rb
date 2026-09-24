cask "keymory" do
  version "1.2"
  sha256 "f0ef0aa105f9e5eeb4b2724670a6fc97703309c558ff8ca6d31568d00495f7f1"

  url "https://github.com/mekh/homebrew-tap/releases/download/keymory-v#{version}/Keymory-#{version}.dmg"
  name "Keymory"
  desc "Menu-bar utility that remembers keyboard input source per app"
  homepage "https://github.com/mekh/keymory"

  livecheck do
    url :url
    regex(/^keymory-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :sonoma

  app "Keymory.app"

  # This non-sandboxed build stores only a single UserDefaults plist. It has no
  # network, no windows, and no sandbox container, so it creates no caches, no
  # HTTP storage, and no saved-state. (The container / Application Scripts paths
  # on disk belong to the sandboxed App Store build, not this one.)
  zap trash: "~/Library/Preferences/toxic0der.Keymory.plist"
end

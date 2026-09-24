cask "warpinator" do
  version "1.2.0"
  sha256 "0019ed098e64591fffed037c8301ae092b814f7cf714ec406a9e27860dda3ce0"

  url "https://github.com/mekh/homebrew-tap/releases/download/warpinator-v#{version}/Warpinator-#{version}.dmg"
  name "Warpinator"
  desc "Send files between devices on a local network"
  homepage "https://github.com/mekh/warpinator-swift"

  livecheck do
    url :url
    regex(/^warpinator-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :ventura

  app "Warpinator.app"

  zap trash: "~/Library/Containers/io.github.emanuelkuhn.warpinator-swift"
end

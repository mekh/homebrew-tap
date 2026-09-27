cask "imark" do
  version "1.1.2"
  sha256 "ae08bb8ffdef81ea376ff33b2eb85c67147fafdfdfdd0b3bd591370a1c23926a"

  url "https://github.com/mekh/homebrew-tap/releases/download/imark-v#{version}/Imark-#{version}.dmg"
  name "Imark"
  desc "Markdown reader with review comments kept inside the file"
  homepage "https://github.com/mekh/imark"

  livecheck do
    url :url
    regex(/^imark-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Imark.app"
  binary "#{appdir}/Imark.app/Contents/Resources/imark"

  zap trash: [
    "~/.imark",
    "~/Library/Caches/pt.miguelsilva.imark",
    "~/Library/Containers/pt.miguelsilva.imark.quicklook",
    "~/Library/HTTPStorages/pt.miguelsilva.imark",
    "~/Library/Preferences/pt.miguelsilva.imark.plist",
    "~/Library/WebKit/pt.miguelsilva.imark",
  ]
end

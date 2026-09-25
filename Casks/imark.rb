cask "imark" do
  version "1.0.0"
  sha256 "b3982ec514f043457a008983c5f11104fea870af53d82e685480ce622722a8bc"

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

# mekh/tap

Homebrew tap for my macOS apps. Every app here ships as a Developer ID–signed,
notarized and stapled `.dmg`, attached to a release of this repository. There is no
source code here — each cask links to its app's own repository.

## Install

```sh
brew install --cask mekh/tap/<cask>
```

That one command taps this repository and installs the cask. Naming the cask in full
also trusts just that cask, so Homebrew 6+ asks for no separate `brew trust` step.

Prefer to tap first? The short names then need a one-time trust:

```sh
brew tap mekh/tap
brew trust --tap mekh/tap
brew install --cask <cask>
```

Update and remove the usual way:

```sh
brew upgrade --cask <cask>
brew uninstall --cask <cask>          # remove the app
brew uninstall --zap --cask <cask>    # also remove its settings
```

## Casks

<!-- casks:start -->
| App | What it does | Install |
| --- | --- | --- |
| [Imark](https://github.com/mekh/imark) | Markdown reader with review comments kept inside the file | `brew install --cask mekh/tap/imark` |
| [Keymory](https://github.com/mekh/keymory) | Menu-bar utility that remembers keyboard input source per app | `brew install --cask mekh/tap/keymory` |
| [Warpinator](https://github.com/mekh/warpinator-swift) | Send files between devices on a local network | `brew install --cask mekh/tap/warpinator` |
<!-- casks:end -->

## Guides

- [Imark](docs/imark.md): installing and updating, and setting up Ask with Claude Code,
  Codex, OpenAI, OpenRouter, the Anthropic API or a local model.

## How releases work

- Each `.dmg` is an asset of a release in this repository, tagged `<cask>-v<version>`
  (for example `keymory-v1.3`), so several apps share one release list without
  clashing.
- `Casks/<cask>.rb` names the version and the SHA-256 of that asset. It changes only
  after the asset is uploaded and the checksum of the bytes GitHub actually serves has
  been confirmed, so a cask never points at a missing or different file.
- Before publishing, the app is notarized and stapled, then the disk image itself is
  signed, notarized and stapled — both pass Gatekeeper even offline.

## Verify a download yourself

```sh
xcrun stapler validate <App>-<version>.dmg
spctl -a -t open --context context:primary-signature -vv <App>-<version>.dmg
shasum -a 256 <App>-<version>.dmg     # compare with sha256 in Casks/<cask>.rb
```

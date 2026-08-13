cask "notch-so-good" do
  version "4.5.0"
  sha256 "477ed90bcd33a9ba28f4f5d4c3d579496f6175efe283b31678b25e2058b49d8b"

  url "https://github.com/deepshal99/notch-so-good/releases/download/v#{version}/NotchSoGood-#{version}.zip"
  name "Notch So Good"
  desc "Pixel-art crab in your notch that watches Claude Code and Codex CLI sessions"
  homepage "https://github.com/deepshal99/notch-so-good"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "NotchSoGood.app"

  # App is ad-hoc signed (not notarized) — clear quarantine so Gatekeeper lets it launch
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NotchSoGood.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.notchsogood.app.plist",
    "~/Library/Caches/com.notchsogood.app",
  ]

  caveats <<~EOS
    Launch the app once and it installs the Claude Code / Codex CLI hooks for
    you. To reinstall them later: menu bar Chawd icon -> Settings -> Reinstall
    hooks.

    For notifications to land on the display you're working on, and to focus the
    exact terminal window, grant Accessibility access when prompted.
  EOS
end

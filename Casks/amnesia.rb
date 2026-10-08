cask "amnesia" do
  version "5.18.2"
  sha256 "a0daf94082dfcc20056225a98a8282aca86ab5ff89035c7ee36d111659caa60b"

  url "https://github.com/navi-crwn/amnesia/releases/download/v#{version}/Amnesia-v#{version}.dmg"
  name "Amnesia"
  desc "Wipes your Mac at every logout, except what you choose to keep"
  homepage "https://navi-crwn.github.io/amnesia/"

  depends_on macos: ">= :sequoia"

  app "Amnesia.app"

  # Turns off the login agent safely (agent file first, so stopping it doesn't wipe).
  # ~/.amnesia (vault, settings) is kept; run uninstall.sh --all to remove it too.
  uninstall early_script: {
    executable: "/bin/bash",
    args:       ["#{appdir}/Amnesia.app/Contents/Resources/engine/uninstall.sh", "--yes", "--keep-app"],
  }

  # Not signed by Apple yet: remove the download quarantine so the app opens.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Amnesia.app"]
  end

  caveats <<~EOS
    Amnesia really deletes data once you turn it on. Read the terms first:
      https://github.com/navi-crwn/amnesia/blob/main/TERMS.md
    To uninstall: brew uninstall --cask amnesia (turns Amnesia off safely).
    To also delete the vault and settings: bash ~/.amnesia/uninstall.sh --all
  EOS
end

cask "amnesia" do
  version "5.21.0"
  sha256 "fa8863f7597bddde08a4c16a398e636907ac30a1a431419cc4c3f17a55ca2dc4"

  url "https://github.com/navi-crwn/amnesia/releases/download/v#{version}/Amnesia-v#{version}.dmg"
  name "Amnesia"
  desc "Wipes your Mac at every logout, except what you choose to keep"
  homepage "https://navi-crwn.github.io/amnesia/"

  depends_on macos: :sequoia

  app "Amnesia.app"

  # Turns off the login agent safely (agent file first, so stopping it doesn't wipe).
  # ~/.amnesia (vault, settings) is kept; run uninstall.sh --all to remove it too.
  uninstall early_script: {
    executable: "/bin/bash",
    args:       ["#{appdir}/Amnesia.app/Contents/Resources/engine/uninstall.sh", "--yes", "--keep-app"],
  }

  # Not signed by Apple yet: remove the download quarantine so the app opens.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Amnesia.app"], must_succeed: false
  end

  caveats <<~EOS
    Amnesia really deletes data once you turn it on. Read the terms first:
      https://github.com/navi-crwn/amnesia/blob/main/TERMS.md
    To uninstall: brew uninstall amnesia (turns Amnesia off safely).
    To also delete the vault and settings: bash ~/.amnesia/uninstall.sh --all
  EOS
end

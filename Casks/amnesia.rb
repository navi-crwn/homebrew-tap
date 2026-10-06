cask "amnesia" do
  version "5.7"
  sha256 "b601ef2362ae62417fbaa7af2a9f90cbc743e217dcf14bde7ebf30fddc4d4a03"

  url "https://github.com/navi-crwn/amnesia-mac/releases/download/v#{version}/Amnesia-v#{version}.zip"
  name "Amnesia"
  desc "Wipes your Mac at every logout, except what you choose to keep"
  homepage "https://navi-crwn.github.io/amnesia-mac/"

  depends_on macos: ">= :sequoia"

  app "Amnesia.app"

  # Not signed by Apple yet: remove the download quarantine so the app opens.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Amnesia.app"]
  end

  caveats <<~EOS
    Before uninstalling, open Amnesia and press Turn Off first.
  EOS
end

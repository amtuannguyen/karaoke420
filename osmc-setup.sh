#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wget "https://github.com/pdf/kodi-callback-daemon/releases/download/v1.5.1/kodi-callback-daemon_1.5.1_armhf.deb"
sudo dpkg -i kodi-callback-daemon_1.5.1_armhf.deb 

sudo cp systemd/karaoke420.service /lib/systemd/system/
sudo cp systemd/karaoke420-search.service /lib/systemd/system/

${SCRIPT_DIR}/setup.sh


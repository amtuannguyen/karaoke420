#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo timedatectl set-timezone America/Toronto

wget "https://github.com/pdf/kodi-callback-daemon/releases/download/v1.5.1/kodi-callback-daemon_1.5.1_amd64.deb"
sudo dpkg -i kodi-callback-daemon_1.5.1_amd64.deb

/vagrant/setup-headless-chrome-testing.sh

ln -s /vagrant karaoke420

cd karaoke420

cat systemd/karaoke420.service | sed 's/osmc/ubuntu/g' > /tmp/karaoke420.service
sudo cp /tmp/karaoke420.service /lib/systemd/system/
cat systemd/karaoke420-search.service | sed 's/osmc/ubuntu/g' > /tmp/karaoke420-search.service
sudo cp /tmp/karaoke420-search.service /lib/systemd/system/

/vagrant/setup.sh



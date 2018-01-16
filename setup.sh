#!/bin/sh

sudo apt-get update
sudo apt-get install -y libsqlite3-dev sqlite3 nodejs libreadline-dev git 
sudo apt-get install -y build-essential
sudo apt-get -y install ruby ruby-dev zlib1g-dev 
sudo apt-get -y install default-jre-headless

sudo systemctl daemon-reload

sudo cp -f kodi-callback-daemon.json /etc/

sudo systemctl enable kodi-callback-daemon
sudo systemctl start kodi-callback-daemon
sudo systemctl enable karaoke420
sudo systemctl enable karaoke420-search

echo "gem: --no-document" >> ~/.gemrc 

sudo gem install bundler --no-document
sudo gem install rails --no-document

bundle
rails db:migrate

sudo systemctl start karaoke420-search
sudo systemctl status karaoke420-search
echo "Waiting 60 seconds for karaoke420 search service to start"
sleep 60
sudo systemctl status karaoke420-search

echo "Seed database... this may take a while"
rails db:seed

rails sunspot:reindex

sudo systemctl start karaoke420
sudo systemctl status karaoke420


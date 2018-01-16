# Karaoke 420

Designed to be simple so it can be used on a smartphone or tablet. Anyone can participate by pointing their smartphone browser to the app's URL. You can add locally hosted karaoke video files, or find songs on YouTube and start singing.

## Screenshots
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3631.PNG)
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3632.PNG)
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3635.PNG)
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3636.PNG)
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3637.PNG)
![screenshot](https://github.com/amtuannguyen/karaoke420/blob/master/public/IMG_3638.PNG)

## Hardware requirements
You can either run this app on a PC, in a Virtual Machine or on a Raspberry PI. The most convenient way is to run this inside a Raspberry PI with OSMC (https://osmc.tv/). 

## Vagrant installation
```
git clone https://github.com/amtuannguyen/karaoke420.git
cd karaoke420
vagrant up
```

## OSMC installation
* Install latest OSMC from https://osmc.tv/download/
* Enable SSH
* Enable JSONRPC (http://kodi.wiki/?title=JSON-RPC_API#Enabling_JSON-RPC)
* Install YouTube addon
* log into OSMC using username/password: osmc
```
git clone https://github.com/amtuannguyen/karaoke420.git
cd karaoke420
./osmc-setup.sh
```

## Change YouTube api key
* Get your YouTube public api key [instructions here](https://github.com/Fullscreen/yt#apps-that-do-not-require-user-interactions)
* log into your box
```
cd karaoke420
rails c
k=Karaoke.first
k.youtube_api_key= "YOUR API KEY"
k.save
```

## Change KODI JSONRPC URL
* log into your box
```
cd karaoke420
rails c
k=Karaoke.first
k.kodi_uri = "http://YOUR_KODI_IP:8080/jsonrpc"
k.save
```

## Set KODI local media directory
* log into your box
```
cd karaoke420
rails c
k=Karaoke.first
k.songs_dir = "/path/to/your/media/on/the/kodi/box"
k.save
```

## Using it
* point your browser to http://ip-of-your-box:3000

class KaraokeController < ApplicationController
  
  def onplay
    logger.info "Player.OnPlay"
    logger.info "Waiting for player to open...sleeping 10 seconds"
    sleep 10
    karaoke = Karaoke.first!
    karaoke.ensure_correct_audio
    karaoke.save_playlist
    respond_to do |f|
      f.html { redirect_to root_url }
    end
  end
  
  def onstop
    logger.info "Player.OnStop"
    respond_to do |f|
      f.html { redirect_to root_url }
    end
  end
  
  def index
    karaoke = Karaoke.first!    
    @playing = karaoke.get_playing
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @personal_playlists = Playlist.all.order("name")
  end
  
  def add
    karaoke = Karaoke.first!
    
    if params[:youtube_id]
      @video = Youtube.get_video(params[:youtube_id])
      status = karaoke.add_youtube_video(@video)
      if status == "OK"
        karaoke.show_notification("Added YouTube Video", "#{@video.title}")
      end
    else
      @song = Song.find_by_number(params[:id])
      if !@song.nil?
        status = karaoke.add(@song)
        if status == "OK"
          karaoke.show_notification("Added #{@song.number.to_s.rjust(4, '0')}", @song.title)
        end
      end
    end
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end

  def play
    karaoke = Karaoke.first!
    
    @player_status = karaoke.get_player_status
    if (@player_status["position"] == -1)
      @playlist = karaoke.get_playlist
      if @playlist.size > 0 and (karaoke.opening_player == 0 or karaoke.opening_player.nil?)
        logger.info "Opening playlist"
        karaoke.opening_player = 1
        karaoke.save
        karaoke.open_playlist
        logger.info "Sleeping 10 seconds waiting for KODI to open the playlist"
        sleep 10
        karaoke.opening_player = 0
        karaoke.save
      end
    else
      karaoke.play_pause
    end
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def next
    karaoke = Karaoke.first!
    karaoke.next
    
    sleep 10
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def previous
    karaoke = Karaoke.first!
    karaoke.previous
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def stop
    karaoke = Karaoke.first!
    karaoke.stop
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def audio
    karaoke = Karaoke.first!
    karaoke.toggle_audio_stream
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def clear
    karaoke = Karaoke.first!
    karaoke.clear_playlist
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def load
    karaoke = Karaoke.first!
    karaoke.load_playlist
    
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @playing = karaoke.get_playing
    @personal_playlists = Playlist.all.order("name")
    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
end

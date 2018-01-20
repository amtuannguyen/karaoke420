class KaraokeController < ApplicationController
  
  def onplay
    logger.info "Player.OnPlay"
    karaoke = Karaoke.first!
    karaoke.save_playlist
    karaoke.ensure_correct_audio
  end

  def onstop
    logger.info "Player.OnStop"
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
      if !@playlist.nil? and @playlist.size > 0
        logger.info "Opening playlist"
        karaoke.open_playlist
      end
    else
      karaoke.play_pause
    end    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def next
    karaoke = Karaoke.first!
    karaoke.next    
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def previous
    karaoke = Karaoke.first!
    karaoke.previous
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def stop
    karaoke = Karaoke.first!
    karaoke.stop
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def audio
    karaoke = Karaoke.first!
    karaoke.toggle_audio_stream
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def clear
    karaoke = Karaoke.first!
    karaoke.clear_playlist
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
  
  def load
    karaoke = Karaoke.first!
    karaoke.load_playlist
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end
end

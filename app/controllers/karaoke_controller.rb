class KaraokeController < ApplicationController
  
  def onplay
    logger.info "Player.OnPlay"

    karaoke = Karaoke.first!

    player_status = karaoke.get_player_status
    position = player_status["position"]
    logger.info "player position: #{position}"
    
    update_ui
  end

  def onstop
    logger.info "Player.OnStop"

    karaoke = Karaoke.first!

    player_status = karaoke.get_player_status
    position = player_status["position"]
    logger.info "player position: #{position}"
    
    if position > 0 
      i = 0
      while i < position
        logger.info "removing playlist position #{i}"
        karaoke.remove_playlist(i)
        i += 1
      end 
    else

    end

    if position == -1 
      karaoke.clear_playlist
    end


    update_ui
  end
  
  def index
  end

  def update_ui
    ActionCable.server.broadcast 'karaoke_channel', playlist: render_playlist, player_status: render_player_status
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
    
    update_ui
    
    respond_to do |f|
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
      f.js
    end
  end
  
  def next
    karaoke = Karaoke.first!
    karaoke.next
    
    update_ui
    
    respond_to do |f|
      f.js
    end
  end
  
  def previous
    karaoke = Karaoke.first!
    karaoke.previous
    
    update_ui
    
    respond_to do |f|
      f.js
    end
  end
  
  def stop
    karaoke = Karaoke.first!
    karaoke.stop
    
    update_ui

    respond_to do |f|
      f.js
    end
  end
  
  def audio
    karaoke = Karaoke.first!
    karaoke.toggle_audio_stream
    respond_to do |f|
      f.js
    end
  end
  
  def clear
    karaoke = Karaoke.first!
    karaoke.clear_playlist
    
    update_ui
    
    respond_to do |f|
      f.js
    end
  end
  
  def load
    karaoke = Karaoke.first!
    karaoke.load_playlist
    
    update_ui
 
    respond_to do |f|
      f.js
    end
  end
  
  def render_playlist
    karaoke = Karaoke.first!
    personal_playlists = Playlist.all.order("name")
    ApplicationController.render(
      partial: 'karaoke/playlist',
      assigns: { playlist: karaoke.get_playlist, player_status: karaoke.get_player_status , personal_playlists: personal_playlists}
    )
  end
  
  def render_player_status
    karaoke = Karaoke.first!
    ApplicationController.render(
      partial: 'karaoke/player_status',
      assigns: { playing: karaoke.get_playing, player_status: karaoke.get_player_status }
    )
  end
end

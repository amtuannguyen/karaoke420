require 'kodi'

class Karaoke < ApplicationRecord
  include Kodi
  
  def get_player_status
    client = get_client
    client.Player.GetProperties playerid: 1, properties: ["position", "time", "totaltime", "audiostreams", "currentaudiostream"]
  end
  
  def get_playing
    client = get_client
    playing = client.Player.GetItem playerid: 1, properties: ["file"]
    playing = playing["item"]
    if !playing.nil?
      add_library_info(playing)
    end
    return playing
  end
  
  def get_playlist
    client = get_client
    playlist = client.Playlist.GetItems playlistid: 1, properties: ["file"]
    playlist = playlist["items"]
    if !playlist.nil?
      playlist.each do |item|
        add_library_info(item)
      end
    end
    return playlist
  end
  
  def save_playlist
    playlist = get_playlist
    if !playlist.nil?
      items = []
      playlist.each do |item|
        if !item["song"].nil?
          items.push(item["song"].number)
        end
      end
      self.playlist = items.join(",")
      self.save
      logger.info "Saved the following songs in playlist #{self.playlist}"
    end
  end
  
  def load_playlist
    logger.info "Loading the following songs from playlist #{self.playlist}"
    items = self.playlist.split(",")
    items.each do |number|
      song = Song.find_by_number(number)
      if !song.nil?
        add(song)
      end
    end
  end

  def open_playlist
    client = get_client
    playlist = client.Player.Open item:{"playlistid" => 1}
  end
  
  def add(song)
    client = get_client
    file = song.file
    if file.start_with?("https://www.youtube.com/watch?v=")
      file = file.sub("https://www.youtube.com/watch?v=", "plugin://plugin.video.youtube/play/?video_id=")
      client.Playlist.Add playlistid:1, item: {"file" => file}
    elsif file.start_with?("plugin://plugin.video.youtube/play/?video_id=")
      client.Playlist.Add playlistid:1, item: {"file" => file}
    else
      client.Playlist.Add playlistid:1, item: {"file" => self.songs_dir + "/" + song.file}
    end
  end
  
  def add_youtube_video(video)
    client = get_client
    file = "plugin://plugin.video.youtube/play/?video_id=#{video.id}" 
    client.Playlist.Add playlistid:1, item: {"file" => file}
  end
  
  def show_notification(title, message)
    client = get_client
    client.GUI.ShowNotification title: title, message: message
  end
  
  def play_pause
    client = get_client
    client.Player.PlayPause playerid: 1
  end
  
  def next
    client = get_client
    client.Player.GoTo playerid: 1, to: 'next'
  end
  
  def previous
    client = get_client
    client.Player.GoTo playerid: 1, to: 'previous'
  end
  
  def stop
    client = get_client
    client.Player.Stop playerid: 1
  end
  
  def clear_playlist
    client = get_client
    client.Playlist.Clear playlistid:1
    self.playlist = ""
    self.save
  end
  
  def toggle_audio_stream
    playing = get_playing
    if !playing.nil?
      song = playing["song"]
      if !song.nil?
        player_status = get_player_status
        current_audio = player_status["currentaudiostream"]["index"]
        audio_streams_count = player_status["audiostreams"].count
        if audio_streams_count == 2
          new_audio = (current_audio == 1) ? 0 : 1
          set_audio_stream(new_audio)
          song.audio_stream = new_audio
          song.save
        end
      end
    end
  end
  
  def ensure_correct_audio
    logger.info "Ensure we got the correct audio stream playing"
    playing = get_playing
    if !playing.nil?
      song = playing["song"]
      if !song.nil?
        logger.info "Song: #{song.number} - #{song.title}"
        5.times do |i|
          logger.info "Changing audio stream to #{song.audio_stream}"
          status = set_audio_stream(song.audio_stream)
          logger.info status
          
          logger.info "Sleeping for 5 second"
          sleep 5
          
          logger.info "Woke up, checking player status to make sure audio stream setting is correct"
          player_status = get_player_status
          current_audio = player_status["currentaudiostream"]["index"]
          audio_streams_count = player_status["audiostreams"].count
          logger.info "Audio streams count: #{audio_streams_count}"
          logger.info "Current audio stream is: #{current_audio}"
          logger.info "Correct audio stream is: #{song.audio_stream}"
          
          break if audio_streams_count >= 1 and audio_streams_count <= 2 and song.audio_stream == current_audio
        end 
      end
    end
  end
  
  def set_audio_stream(index)
    client = get_client
    client.Player.SetAudioStream playerid: 1, stream: index
  end
  
  def set_volume(volume)
    client = get_client
    client.Application.SetVolume volume: volume
  end
  
  def get_client
    if @client.nil?
      @client = Kodi::Client.new(self.kodi_uri, 
      {
        "GUI" => ["ShowNotification"], 
        "Player" => ["GetItem", "GetProperties", "Open", "PlayPause", "GoTo", "Stop", "Open", "SetAudioStream"], 
        "Playlist" => ["GetItems", "GetProperties", "Add", "Remove", "Clear"],
        "Application" => ["GetProperties", "SetVolume"]
      })
    end
    return @client
  end
  
  def add_library_info(item)
    return item if item["file"].nil?
    
    # check if this is a local file based song
    f = item["file"].sub(self.songs_dir + "/", "")
    song = Song.find_by_file(f)
    if !song.nil?
      item["title"] = song.title
      item["number"] = song.number
      item["song"] = song
      return item
    end
    
    # check if this is a cataloged YouTube song
    f = item["file"].sub("plugin://plugin.video.youtube/play/?video_id=", "https://www.youtube.com/watch?v=")
    song = Song.find_by_file(f)
    if !song.nil?
      item["title"] = song.title
      item["number"] = song.number
      item["song"] = song
      return item
    else
      youtube_video_id = item["file"].sub("plugin://plugin.video.youtube/play/?video_id=", "")
      video = Youtube.get_video(youtube_video_id)
      if !video.nil?
        item["label"] = video.title
        item["youtube_video_id"] = youtube_video_id
        return item
      end
    end
  end
end

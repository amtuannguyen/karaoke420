class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_player_statuses, only: [:index]
  
  def set_player_statuses
    karaoke = Karaoke.first!    
    @playing = karaoke.get_playing
    @playlist = karaoke.get_playlist
    @player_status = karaoke.get_player_status
    @personal_playlists = Playlist.all.order("name")
  end
end

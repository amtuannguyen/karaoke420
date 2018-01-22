class SongsController < ApplicationController
  def index
    @personal_playlists = Playlist.all.order('name')
    if !params[:singer_id].nil?
      @chosen_singer = Singer.find(params[:singer_id])
      if !@chosen_singer.nil?
        @songs = @chosen_singer.songs.order('title')
      end
    elsif !params[:playlist_id].nil?
      @chosen_playlist = Playlist.find(params[:playlist_id])
      if !@chosen_playlist.nil?
        @songs = @chosen_playlist.songs.order('title')
      end
    elsif params[:letter].nil?
      @listing_recently_added_songs = true
      @songs = Song.all.order("created_at DESC").limit(100)
    else
      @letter = params[:letter]
      @songs = Song.find_by_first_letter_of_title(@letter)
    end
    
    respond_to do |f|
      f.html { render :action => "index" }
      f.js
    end
  end
  
  def browse
    index
  end
    
  def new
    @song = Song.new
    @song.number = Song.maximum("number") + 1
    if !params[:youtube_video_id].nil?
      video = Youtube.get_video(params[:youtube_video_id])
      if !video.nil?
        @song.title = video.title
        @song.file = "plugin://plugin.video.youtube/play/?video_id=" + video.id
      end
    end
  end
  
  def show
    @personal_playlists = Playlist.all.order('name')
    @song = Song.find(params[:id])
  end
  
  def create
    @song = Song.new(song_params)
    if @song.save
      @song.associate_singers
      @song.update_singer_names
      Sunspot.commit
      redirect_to @song
    else
      render 'new'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end
  
  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      @song.associate_singers
      @song.update_singer_names
      Sunspot.commit
      redirect_to @song
    else
      render 'edit'
    end
  end
    
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end
  
  def search
    @personal_playlists = Playlist.all.order('name')
    @query = params[:query]
    @songs = Song.search do
      keywords params[:query]
    end.results
    respond_to do |f|
      f.html { render :action => "index" }
      f.js
    end
  end
  
  def add_to_playlist
    @song = Song.find(params[:song_id])
    if !params[:playlist_id].nil?
      @playlist = Playlist.find(params[:playlist_id])
      @song.add_to_playlist(@playlist)
      @song.save
    end
    
    respond_to do |format|
      format.html { redirect_to song_path(@song) }
      format.js
    end
  end
  
  def remove_from_playlist
    @song = Song.find(params[:song_id])
    if !params[:playlist_id].nil?
      @playlist = Playlist.find(params[:playlist_id])
      @song.playlists.delete(@playlist)
      @song.save
    end
    
    respond_to do |format|
      format.html { redirect_to song_path(@song) }
      format.js
    end
  end
  
  private
    def song_params
      params.require(:song).permit(:title, :singer1, :singer2, :singer3, :singer4, :number, :file, :is_youtube_video)
    end
end

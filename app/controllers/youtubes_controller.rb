class YoutubesController < ApplicationController
  def search
    @videos = Youtube.search_videos(params[:query])
    
    respond_to do |f|
      f.html { render :action => "index" }
      f.js
    end
  end
end

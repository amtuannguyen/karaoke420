class Youtube < ApplicationRecord
  validates_uniqueness_of :channel_title
  validates_uniqueness_of :channel_id
  validates :channel_title, presence: true
  validates :channel_id, presence: true
  
  def self.search_videos(q)
    Yt.configure do |config| 
      config.api_key = self.get_api_key
    end
    @videos = Yt::Collections::Videos.new.where(q: "karaoke #{q}", safe_search: 'none', type: 'video', videoDefinition: 'high')

    # cache video metadata
    @videos.first(100).each do |video|
      cache_key = "youtube_video_" + video.id;
      logger.info "caching search result #{cache_key}"
      Rails.cache.write(cache_key, video, expires_in: 48.hours)
    end
  end
  
  def self.get_video(video_id)
    Yt.configure do |config|
      config.api_key = self.get_api_key
    end

    logger.info "get_video #{video_id}"

    cache_key = "youtube_video_" + video_id;
    video = Rails.cache.read(cache_key)
    if video.nil?
      logger.info "not in cache  #{cache_key}, calling YouTube API to fetch video meta"
      video = Yt::Collections::Videos.new.where(id: video_id, safe_search: 'none', type: 'video', videoDefinition: 'high').first
      logger.info "caching #{cache_key}"
      Rails.cache.write(cache_key, video, expires_in: 48.hours)
    else
      logger.info "cache found #{cache_key}"
    end
    logger.info "video title: #{video.title}"
    return video
  end
  
  def self.get_api_key
    key = ENV['YOUTUBE_API_KEY'].blank? ? Karaoke.first.youtube_api_key : ENV['YOUTUBE_API_KEY']
  end
end

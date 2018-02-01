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
  end
  
  def self.get_video(video_id)
    Yt.configure do |config|
      config.api_key = self.get_api_key
    end
    Yt::Collections::Videos.new.where(id: video_id, safe_search: 'none', type: 'video', videoDefinition: 'high').first
  end
  
  def self.get_api_key
    key = ENV['YOUTUBE_API_KEY'].blank? ? Karaoke.first.youtube_api_key : ENV['YOUTUBE_API_KEY']
  end
end

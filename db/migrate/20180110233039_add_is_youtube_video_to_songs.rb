class AddIsYoutubeVideoToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :is_youtube_video, :integer
  end
end

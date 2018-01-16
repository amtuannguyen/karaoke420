class RemoveIsYoutubeVideoFromSongs < ActiveRecord::Migration[5.1]
  def change
    remove_column :songs, :is_youtube_video, :integer
  end
end

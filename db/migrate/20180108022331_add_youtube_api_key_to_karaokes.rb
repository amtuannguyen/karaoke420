class AddYoutubeApiKeyToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :youtube_api_key, :string
  end
end

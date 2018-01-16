class AddAudioStreamToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :audio_stream, :integer
  end
end

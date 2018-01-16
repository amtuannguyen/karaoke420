class ChangeDefaultAudioStreamValueForSongs < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:songs, :audio_stream, 0)
  end
end

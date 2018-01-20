class AddKodiChangeAudioDelayToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :kodi_change_audio_delay, :integer, :default => 5
  end
end

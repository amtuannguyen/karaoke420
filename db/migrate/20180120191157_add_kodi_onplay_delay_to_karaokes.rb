class AddKodiOnplayDelayToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :kodi_onplay_delay, :integer, :default => 10
  end
end

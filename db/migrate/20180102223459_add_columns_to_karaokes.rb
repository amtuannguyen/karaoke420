class AddColumnsToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :kodi_uri, :string
    add_column :karaokes, :songs_dir, :string
  end
end

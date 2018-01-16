class AddPlaylistToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :playlist, :string
  end
end

class AddSinger4ToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :singer4, :string
  end
end

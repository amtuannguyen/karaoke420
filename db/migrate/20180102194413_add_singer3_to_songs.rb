class AddSinger3ToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :singer3, :string
  end
end

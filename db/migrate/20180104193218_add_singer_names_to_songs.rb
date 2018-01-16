class AddSingerNamesToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :singer_names, :string
  end
end

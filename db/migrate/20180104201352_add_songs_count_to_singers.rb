class AddSongsCountToSingers < ActiveRecord::Migration[5.1]
  def change
    add_column :singers, :songs_count, :integer
  end
end

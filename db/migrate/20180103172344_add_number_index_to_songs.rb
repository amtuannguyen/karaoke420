class AddNumberIndexToSongs < ActiveRecord::Migration[5.1]
  def change
    add_index :songs, :number
  end
end

class AddNumberToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :number, :integer
  end
end

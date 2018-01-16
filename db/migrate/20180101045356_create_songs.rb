class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :singer1
      t.string :singer2
      t.string :file

      t.timestamps
    end
  end
end

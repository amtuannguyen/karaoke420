class CreateJoinTableSingersSongs < ActiveRecord::Migration[5.1]
  def change
    create_join_table :singers, :songs do |t|
      # t.index [:singer_id, :song_id]
      # t.index [:song_id, :singer_id]
    end
  end
end

class RemoveOpeningPlayerFromKaraoke < ActiveRecord::Migration[5.1]
  def change
    remove_column :karaokes, :opening_player, :integer
  end
end

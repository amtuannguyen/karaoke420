class ReAddOpeningPlayerToKaraokes < ActiveRecord::Migration[5.1]
  def change
    add_column :karaokes, :opening_player, :integer
  end
end

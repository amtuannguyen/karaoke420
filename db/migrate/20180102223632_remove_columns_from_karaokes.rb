class RemoveColumnsFromKaraokes < ActiveRecord::Migration[5.1]
  def change
    remove_column :karaokes, :played_label, :string
    remove_column :karaokes, :played_thumbnail, :string
  end
end

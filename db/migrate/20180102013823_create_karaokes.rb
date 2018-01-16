class CreateKaraokes < ActiveRecord::Migration[5.1]
  def change
    create_table :karaokes do |t|
      t.string :played_label
      t.string :played_thumbnail

      t.timestamps
    end
  end
end

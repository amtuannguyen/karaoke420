class CreateYoutubes < ActiveRecord::Migration[5.1]
  def change
    create_table :youtubes do |t|
      t.string :channel_id
      t.string :channel_title

      t.timestamps
    end
  end
end

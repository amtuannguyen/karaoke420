class Singer < ApplicationRecord
  has_and_belongs_to_many :songs
  
  validates :name, presence: true
  validates_uniqueness_of :name
  
  searchable auto_index: false do
    text :name, :stored => true
  end

  def self.find_by_first_letter_of_name(letter)
    Singer.where("upper(name) LIKE ?", "#{(letter.upcase)}%").order('name')
  end
  
  def self.all_update_songs_count
    Singer.find_each do |singer|
      singer.songs_count = singer.songs.count
      singer.save
    end
  end
end

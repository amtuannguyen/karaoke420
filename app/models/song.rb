class Song < ApplicationRecord
  has_and_belongs_to_many :singers
  has_and_belongs_to_many :playlists
  
  validates :title, presence: true
  validates :number, presence: true
  validates :file, presence: true
  
  validates_uniqueness_of :number
  validates_uniqueness_of :file
  
  searchable auto_index: false do
    text :title, :stored => true
    text :number, :stored => true
  end
  
  def self.find_by_first_letter_of_title(letter)
      Song.where("upper(title) LIKE ?", "#{(letter.upcase)}%").order('title')
  end
  
  def update_singer_names
    names = []
    singers.each do |singer|
      names.push(singer.name)
    end
    self.singer_names = names.join(", ")
  end
  
  def associate_singers
    associate_singer(self.singer1)
    associate_singer(self.singer2)
    associate_singer(self.singer3)
    associate_singer(self.singer4)
  end
  
  def associate_singer(singer_name)
    if !singer_name.blank?
      singer = Singer.find_by_name(singer_name)
      if singer.nil?
        logger.info "Singer #{singer_name} does not exist, creating new"
        singer = Singer.new
        singer.name = singer_name
        singer.save
        self.singers << singer
      else
        logger.info "Singer #{singer_name} exist"
        if !self.singers.find_by_id(singer.id)
          logger.info "Adding #{singer.id} to this song"
          self.singers << singer
        end
      end
    end
  end
  
  def add_to_playlist(playlist)
    if !playlist.nil?
      if !self.playlists.find_by_id(playlist.id)
        logger.debug "Adding #{self.title} to #{playlist.name}"
        self.playlists << playlist
      end
    end
  end
  
  def self.all_associate_singers
    Song.find_each do |s|
      s.associate_singers
    end
  end
  
end

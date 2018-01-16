class Playlist < ApplicationRecord
  has_and_belongs_to_many :songs
  validates_uniqueness_of :name
  validates :name, presence: true
end

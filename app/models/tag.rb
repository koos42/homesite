class Tag < ActiveRecord::Base
  has_many :comic_tags, uniq: true
  has_many :comics, through: :comic_tags, uniq: true

  attr_accessible :tag, :comics
end

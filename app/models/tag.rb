class Tag < ActiveRecord::Base
  has_many :comic_tags
  has_many :comics, through: :comic_tags

  attr_accessible :tag, :comics
end

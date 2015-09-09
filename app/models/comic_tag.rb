class ComicTag < ActiveRecord::Base
  belongs_to :comic
  belongs_to :tag
end

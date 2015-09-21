class ComicTag < ActiveRecord::Base
  belongs_to :comic
  belongs_to :tag
  validate   :uniqueness

  def uniqueness
    if ComicTag.where(comic_id: self.comic.id, tag_id: self.tag.id).any?
      errors.add(:uniqueness, "comics may not be tagged by the same tag more than once")
    end
  end
end

class Comic < ActiveRecord::Base
  validates :title, :presence => true
  validates :date,  :presence => true
  validates :blurb, :presence => true

  has_attached_file :photo, 
                      { 
                        :styles => { 
                        :thumb=> "100x100#" 
                      } 
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})
  has_attached_file :original_photo, 
                      { 
                        :styles => { 
                        :thumb=> "100x100#" 
                      } 
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})

  attr_accessor :next, :prev

  def setup_next_and_prev
    @next = Comic.where("date > ?", date).where(:publish => true).order("date asc").first 
    @prev = Comic.where("date < ?", date).where(:publish => true).order("date desc").first
    puts self.next
    puts self.prev
  end
end

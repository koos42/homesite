class Comic < ActiveRecord::Base
  validates :title, :presence => true
  validates :date,  :presence => true
  validates :blurb, :presence => true

  attr_accessor :url


  has_attached_file :photo, 
                      { 
                        :styles => { 
                        :thumb=> "100x100#", 
                        :display => "800>x1",
                        :wide => "1000>x1",
                      } 
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})
  has_attached_file :thumbnail, 
                      { 
                        :styles => { 
                        :display => "500x500",
                        :thumb=> "100x100#",
                      } 
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})

  def next
    if !@next
      @next = Comic.where("date > ?", date).where("date <= ?", DateTime.now).where(:publish => true).order("date asc").first
    else
      @next
    end
  end

  def prev
    if !@prev
      @prev = Comic.where("date < ?", date).where("date <= ?", DateTime.now).where(:publish => true).order("date desc").first
    else
      @prev
    end
  end

  def url
    return @url if @url
    @url = "http://anotherwebcomic.com/comics/#{self.id}"
    return @url
  end

end

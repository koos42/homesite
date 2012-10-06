class Comic < ActiveRecord::Base
  before_validation :sluggify

  validates :title, :presence => true
  validates :date,  :presence => true
  validates :blurb, :presence => true
  validates :slug,  :presence => true

  attr_accessor :url

  has_attached_file :photo, 
                      { 
                        :styles => { 
                          :thumb=> "100x100#", 
                          :prev => "200>x1",
                          :display => "800>x1",
                          :wide => "1000>x1",
                        },
                        :url => "/system/:attachment/:id/:style/:filename",
                      }.merge(PAPERCLIP_STORAGE_CONFIG || {})

  has_attached_file :thumbnail, 
                      { 
                        :styles => { 
                          :display => "500x500",
                          :thumb=> "100x100#",
                          :fb=> "200x200#",
                          :prev => "200>x1",
                        },
                        :url => "/system/:attachment/:id/:style/:filename",
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
    @url = "http://#{request.host}/#{self.slug}"
    return @url
  end

  def thumbnail_url(size = :thumb)
    !(self.thumbnail.url =~ /missing\.(png|gif|jpg|jpeg)/ ) ? self.thumbnail.url(size) : self.photo.url(size)
  end

  private
  def sluggify
    self.slug = self.slug ? self.slug :
                self.title.downcase.gsub(/[^(\w\s)]/,'').gsub(/\s/, '_')
  end
end

class Comic < ActiveRecord::Base
  validates :title, :presence => true
  validates :date,  :presence => true
  validates :blurb, :presence => true

  has_attached_file :photo, :styles => { :thumb=> "100x100#" }
end

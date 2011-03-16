class Comic < ActiveRecord::Base
  validates :title, :presence => true
  validates :date,  :presence => true
  validates :blurb, :presence => true

  has_attached_file :photo, :styles => { :thumb=> "100x100#" }
#                    :storage => :s3,
#                    :bucket => 'webcomic_photos',
#                    :s3_credentials => {
#                      :access_key_id => ENV['S3_KEY'],
#                      :secret_access_key => ENV['S3_SECRET']
#                    }
end

require 'paperclip'

class Goody < ActiveRecord::Base
  has_attached_file :goody_file, {
                      :styles => {
                        :thumb=> "100x100#"
                      }
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})

  ACCEPTED_IMAGE_TYPES = %w[ image/jpeg image/jpg image/png image/gif ]
  validates_attachment_content_type :goody_file, :content_type => ACCEPTED_IMAGE_TYPES
end

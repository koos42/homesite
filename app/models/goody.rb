require 'paperclip'

class Goody < ActiveRecord::Base

  has_attached_file :goody_file, {
                      :styles => {
                        :thumb=> "100x100#"
                      }
                    }.merge(PAPERCLIP_STORAGE_CONFIG || {})
end

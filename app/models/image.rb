class Image < ActiveRecord::Base
  belongs_to :product
  mount_uploader :file, ImageUploader

end

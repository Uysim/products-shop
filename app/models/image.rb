class Image < ActiveRecord::Base
  belongs_to :product
  mount_uploader :file, ImageUploader

  # after_save do
  #   if imageable_type == 'Product'
  #     file.recreate_versions!(:thumb)
  #   end
  # end
end

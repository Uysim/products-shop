class SliderImage < ActiveRecord::Base
  belongs_to :slider
  mount_uploader :file, SliderUploader
end

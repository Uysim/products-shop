class Slider < ActiveRecord::Base
  has_many :slider_images, dependent: :destroy

  accepts_nested_attributes_for :slider_images, reject_if: :all_blank, allow_destroy: true
end

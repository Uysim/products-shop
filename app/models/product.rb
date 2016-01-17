class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:file].blank?}, allow_destroy: true

end

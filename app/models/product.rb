class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :fields, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:file].blank?}, allow_destroy: true
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true


  scope :rows, lambda { |n| limit(n*4) }

  def related
    category.products.where("id != #{id}").rows(1)
  end

  def self.search(str)
    search_col = ['products.name', 'summary', 'description', 'fields.value']
    search_string = search_col.map { |e| "#{e} LIKE :search" }.join(' OR ')
    joins(:fields).where(search_string, search: "%#{str}%").uniq
  end
end

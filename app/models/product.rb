class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :fields, dependent: :destroy

  validates :images, length: { minimum: 1}

  accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:file].blank?}, allow_destroy: true
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true


  scope :rows, lambda { |n| limit(n*4) }
  scope :of, lambda { |category_ids| where(category_id: category_ids) }
  scope :feature, -> { where(feature: true) }
  scope :rank, -> { order(feature: :desc, updated_at: :asc) }

  def related
    category.products.where("id != #{id}").rows(1)
  end

  def self.search(str)
    search_col = ['products.name', 'summary', 'description', 'fields.value']
    search_string = search_col.map { |e| "lower(#{e}) LIKE :search" }.join(' OR ')
    includes(:fields).where(search_string, search: "%#{str.downcase}%").references(:fields)
  end
end

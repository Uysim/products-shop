class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :fields, dependent: :destroy

  validates :images, length: { minimum: 1}

  accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:file].blank?}, allow_destroy: true
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true


  scope :rows, lambda { |n| limit(n*6) }
  scope :of, lambda { |category_ids| where(category_id: category_ids) }
  scope :available, -> { where(sold: false) }
  scope :rank, -> { available.order(feature: :desc, updated_at: :asc) }
  scope :feature, -> { available.where(feature: true) }
  scope :latest, -> { reorder(created_at: :desc) }

  default_scope { order(:sort_order) }

  def related
    category.products.rank.where("id != #{id}").rows(1)
  end

  def self.search(str)
    search_col = ['products.name', 'summary', 'description', 'fields.value']
    search_string = search_col.map { |e| "lower(#{e}) LIKE :search" }.join(' OR ')
    includes(:fields).where(search_string, search: "%#{str.downcase}%").references(:fields)
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def image_thumb_url
    if images.any?
      images.first.file.thumb.url
    end
  end
end

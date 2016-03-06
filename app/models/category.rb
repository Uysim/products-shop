class Category < ActiveRecord::Base
  has_many :subcategories, -> { order(:updated_at)}, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  has_many :products,-> { order(:updated_at)}, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  scope :main_categories, -> { where(parent: nil).includes(:subcategories) }
  scope :of, lambda { |ids| where(parent_id: ids) }

  def main?
    parent.nil?
  end
  def sub?
    !parent.nil?
  end

  def subcategories_ids(ids=nil)
    ids ||= [id]
    sub_ids = Category.of(ids).ids.unshift(ids).flatten.uniq
    return ids if ids.sort == sub_ids.sort
    subcategories_ids(sub_ids)

  end

  def all_products
    Product.of(subcategories_ids)
  end

  def feature_products
    all_products.feature
  end
  def summary_products
    list_products.rows(4)
  end
  def list_products
    all_products.rank
  end

  def to_param
    "#{id} #{name}".parameterize
  end
end

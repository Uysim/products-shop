class Category < ActiveRecord::Base
  has_many :subcategories, -> { order(:updated_at)}, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  has_many :products,-> { order(:updated_at)}, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  scope :main_categories, -> { where(parent: nil) }
  # def self.main_categories
  #   where(parent: nil)
  # end

  def main?
    parent.nil?
  end
  def sub?
    !parent.nil?
  end

  def all_products
    ids = subcategories.map(&:id).unshift(id)
    Product.of(ids)
  end

  def feature_products
    all_products.feature
  end
end

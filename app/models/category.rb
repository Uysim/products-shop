class Category < ActiveRecord::Base
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  has_many :products, -> { order(updated_at: :desc) }, dependent: :destroy
  belongs_to :parent, class_name: 'Category'

  def self.main_categories
    where(parent: nil)
  end
end

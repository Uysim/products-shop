class AddSortOrderToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sort_order, :integer, default: 1
    Category.all.each do |category|
      category.products.order(:updated_at).each_with_index do |product, index|
        product.update_attributes(sort_order: index+1)
      end
    end
  end
end

class ProductSweeper < ActionController::Caching::Sweeper
  observe Product
  def after_save(product)
    expire_cache(product)
  end

  def after_destroy(product)
    expire_cache(product)
  end

  private
    def expire_cache(product)
      expire_action root_path
      expire_action category_product_path(product.category, product)
      expire_category_cache(product.category)
    end
    def expire_category_cache(category)
      expire_action category_products_path(category)
      expire_category_cache(category.parent) unless category.parent.nil?
    end
end

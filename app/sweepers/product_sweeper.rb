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
      Rails.cache.clear
    end
end

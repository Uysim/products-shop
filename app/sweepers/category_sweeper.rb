class CategorySweeper < ActionController::Caching::Sweeper
  observe Category
  include Rails.application.routes.url_helpers
  def after_save(category)
    expire_cache(category)
  end

  def after_destroy(category)
    expire_cache(category)
  end

  private
    def expire_cache(category)
      Rails.cache.clear
    end
end

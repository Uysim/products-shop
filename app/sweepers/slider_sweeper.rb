class SliderSweeper < ActionController::Caching::Sweeper
  observe Slider
  def after_save(slider)
    expire_cache(slider)
  end

  def after_destroy(slider)
    expire_cache(slider)
  end

  private
    def expire_cache(slider)
      Rails.cache.clear
    end
end

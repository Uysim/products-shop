class PagesController < ApplicationController
  before_action :set_meta
  def home
    @slider = Slider.find_by(name: 'Home')
  end

  def about

  end

  def search
    @products = Product.search(params[:search][:query]).paginate(page: params[:page], per_page: 32)
  end

  private
    def set_meta
      @meta_tag = MetaTag.new({request: request})
      @meta_tag.set_title(params[:action].capitalize)
      set_meta_tags(@meta_tag.meta_tag)
    end
end

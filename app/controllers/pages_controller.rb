class PagesController < ApplicationController

  def home
    @slider = Slider.find_by(name: 'Home')
  end

  def about

  end

  def search
    @products = Product.search(params[:search][:query]).paginate(page: params[:page], per_page: 32)
  end
end
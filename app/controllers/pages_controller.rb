class PagesController < ApplicationController
  def home
  end

  def about

  end

  def search
    @products = Product.search(params[:search][:query]).paginate(page: params[:page], per_page: 16)
  end
end
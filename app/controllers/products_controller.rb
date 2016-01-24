class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show]

  def index
    @products = @category.products.paginate(page: params[:page], per_page: 32)
  end

  def show
  end


  private
    def set_product
      @product = @category.products.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end
end
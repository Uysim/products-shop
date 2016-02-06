class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show]

  def index
    render :index_with_sub if @category.subcategories.any?
  end

  def show
  end


  private
    def set_product
      @product = @category.products.find(params[:id])
    end

    def set_category
      @category = @main_categories.find(params[:category_id])
    end
end
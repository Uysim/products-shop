class ProductsController < ApplicationController
  caches_action :index, cache_path: Proc.new{ request.path }
  caches_action :show, cache_path: Proc.new{ request.path }, if: Proc.new { !admin_signed_in? }
  before_action :set_category
  before_action :set_product, only: [:show]
  before_action :set_meta, only: [:index, :show]
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
      @category = Category.find(params[:category_id])
    end

    def set_meta
      meta_tag = MetaTag.new({request: request, category: @category, product: @product})
      set_meta_tags(meta_tag.meta)
    end

end

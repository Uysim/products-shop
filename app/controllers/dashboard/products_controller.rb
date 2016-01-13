module Dashboard
  class ProductsController < AdminController
    before_action :set_category
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    layout 'admin'

    def index
      @products = @category.products
    end

    def show
    end

    def new
      @product = @category.products.new
    end

    def edit
    end

    def create
      @product = @category.products.new(product_params)
      if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    end

    private
      def set_product
        @product = @category.products.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :price, :category_id, :description)
      end

      def set_category
        @category = Category.find(params[:category_id])
      end
  end
end
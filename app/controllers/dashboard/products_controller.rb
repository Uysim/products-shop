module Dashboard
  class ProductsController < AdminController
    before_action :set_category
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = @category.products
    end

    def show
    end

    def new
      @product = @category.products.new
      @product.images.build
    end

    def edit
      @product.images.build unless @product.images.any?
    end

    def create
      @product = @category.products.new(product_params)
      if @product.save
        expire_cache
        redirect_to category_product_url(@category, @product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def update
      if @product.update(product_params)
        expire_cache
        redirect_to category_product_url(@product.category, @product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_category_products_url(@category), notice: 'Product was successfully destroyed.'
    end

    def order
      order_params[:ids].each do |id|
        @category.products.find(id).touch
      end
      expire_action(category_products_path(@category))
      redirect_to admin_category_products_url(@category)
    end

    private
      def set_product
        @product = @category.products.find(params[:id])
      end

      def product_params
        params.require(:product).permit(
          :name, :price, :status, :category_id, :description, :summary, :sold, :feature,
          fields_attributes: [:id, :name, :value,:_destroy],
          images_attributes: [:id, :file, :_destroy]
      )
      end

      def set_category
        @category = Category.find(params[:category_id])
      end

      def order_params
        params.require(:products)
      end

      def expire_cache
        expire_action(category_product_path(@category, @product))
        expire_category(@category)
      end

      def expire_category(category)
        expire_action(category_products_path(category))
        expire_action(category_products_path(category.parent)) if category.parent.present?
      end
  end
end

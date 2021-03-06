module Dashboard
  class CategoriesController < AdminController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
      @main_categories = Category.main_categories
    end

    def show
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        Rails.cache.clear
        redirect_to admin_category_products_url(@category), notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        Rails.cache.clear
        redirect_to admin_category_products_url(@category), notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      Rails.cache.clear
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    end

    def order
      order_params[:ids].each do |id|
        Category.find(id).touch
      end
      Rails.cache.clear
      redirect_to admin_categories_url
    end

    private
      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :description, :parent_id, :content_position)
      end

      def order_params
        params.require(:categories)
      end
  end
end

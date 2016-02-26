module Dashboard
  class SlidersController < AdminController
    cache_sweeper :slider_sweeper, :only => [:create, :update, :destroy]
    before_action :set_slider, only: [:update, :edit]
    def index
      @sliders = Slider.all
    end

    def new
      @slider = Slider.new
    end

    def create
      @slider = Slider.new(slider_params)
      if @slider.save
        redirect_to admin_sliders_url, notice: 'Slider was successfully created.'
      else
        render :new
      end
    end

    def update
      if @slider.update(slider_params)
        redirect_to admin_sliders_url, notice: 'Slider was successfully updated.'
      else
        render :edit
      end
    end

    def edit

    end
    private
      def slider_params
        params.require(:slider).permit(
          :name,
          slider_images_attributes: [:id, :file, :link_url, :_destroy]
        )
      end

      def set_slider
        @slider = Slider.find(params[:id])
      end
  end
end

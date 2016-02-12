module SliderHelper
  def slider(slider)
    BootstrapSliders.new(self, slider).html
  end

  class BootstrapSliders
    def initialize(view, slider)
      @view   = view
      @images = slider.slider_images
      @uid    = SecureRandom.hex(6)
    end

    def html
      options = {
        class: 'carousel slide',
        id: uid
      }
      content = view.safe_join([indicators,slides,controls])
      view.content_tag(:div, content, options)
    end

    private

    attr_accessor :view, :images, :uid

    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

    def indicators
      contents = images.count.times.map { |index| indicator_tag(index) }
      content_tag(:ol, safe_join(contents), class: 'carousel-indicators')
    end

    def slides
      contents = images.map.with_index { |image, index| slide_tag(image, index) }
      content_tag(:div, safe_join(contents), class: 'carousel-inner')
    end


    def controls
      safe_join([control_tag('left'), control_tag('right')])
    end


    def indicator_tag(index)
      options = {
        class: index.zero? ? 'active' : '',
        data: {
          target: "##{uid}",
          slide_to: index
        }
      }
      content_tag(:li, '', options)
    end

    def slide_tag(image, index)
      options = {
        class: index.zero? ? 'item active' : 'item'
      }
      image_tag = image_tag(image.file.url, class: 'img-responsive')
      link_tag  = link_to('View Detail >', image.link_url, class: 'detail')
      contents  = [image_tag, link_tag]
      content_tag(:div, safe_join(contents), options)
    end

    def control_tag(direction)
      options = {
        class: "#{direction} carousel-control",
        data: { slide: direction == 'left' ? 'prev' : 'next' }
      }
      icon = content_tag(:i, nil, class: "glyphicon glyphicon-chevron-#{direction}")
      link_to(icon, "##{uid}", options)
    end
  end
end
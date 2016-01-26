module NavbarHelper
  def navbar
    Navbar.new(@main_categories, params, self).html
  end
  private
    class Navbar
      include Rails.application.routes.url_helpers

      def initialize(categories, params, view)
        @categories = categories
        @params = params
        @view = view
      end

      def html
        option = {
          class: 'navbar navbar-default container'
        }
        contents = [navbar_header, navbar_collapse]
        container = content_tag(:div, safe_join(contents), {class: 'container-fluid'})
        content_tag(:nav, container, option)
      end

      private
        attr_accessor :view, :categories, :params
        delegate :content_tag, :link_to, :safe_join, to: :view
        def navbar_header
          option = {
            class: 'navbar-header'
          }
          contents = [collapse_button, navbar_brand]
          content_tag(:div, safe_join(contents), option)
        end

        def navbar_collapse
          option = {
            class: 'collapse navbar-collapse',
            id: 'gtc-navbar'
          }
          contents = [navbar_left, navbar_right]
          content_tag(:div, safe_join(contents), option)
        end

        def navbar_left
          option = {
            class: 'nav navbar-nav'
          }
          contents = main_category.unshift(home)
          content_tag(:ul, safe_join(contents), option)
        end

        def navbar_right
          option = {
            class: 'nav navbar-nav navbar-right'
          }
          content_tag(:ul, about, option)
        end

        def home
          link = link_to 'Home', root_path
          content_tag(:li, link)
        end

        def main_category
          categories.map do |category|
            link = link_to category.name, category_products_path(category)
            content_tag(:li, link)
          end
        end

        def about
          link = link_to 'About', about_path
          content_tag(:li, link)
        end

        def navbar_brand
          option = {
            class: 'navbar-brand visible-xs visible-sm'
          }
          label = 'GTC Computer'
          content_tag(:div, label, option)
        end

        def collapse_button
          option = {
            class: 'navbar-toggle collapsed',
            "aria-expanded" => "false",
            "data-target" => "#gtc-navbar",
            "data-toggle" => "collapse",
            :type => "button"
          }
          icon_bars = [1,2,3].map{|i| icon_bar}
          sr_only = content_tag(:span, nil,{class: 'sr-only'})
          contents = icon_bars.unshift(sr_only)
          content_tag(:button, safe_join(contents), option)
        end

        def icon_bar
          content_tag(:span,nil,{class: 'icon-bar'})
        end
    end
end
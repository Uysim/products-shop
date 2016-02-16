module NavbarHelper
  def navbar
    Navbar.new(@main_categories, params, self).html
  end
  private
    class Navbar
      include Rails.application.routes.url_helpers
      include FontAwesome::Rails::IconHelper
      def initialize(categories, params, view)
        @categories = categories
        @params = params
        @view = view
      end

      def html
        option = {
          class: 'navbar navbar-default'
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
          contents = main_categories.unshift(home)
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

        def main_categories
          categories.map do |category|
            contents = []
            contents << link_to(category.name, category_products_path(category))
            if category.subcategories.any?
              # fa_icon('arrow-circle-down')
              contents << link_to('', 'javascript:void(0)', class: "dropdown-toggle pull-right visible-xs visible-sm", "data-toggle"=>"dropdown", "role"=>"button", "aria-haspopup"=>"true", "aria-expanded"=>"false")
              contents << subcategories(category.subcategories)
            end
            content_tag(:li, safe_join(contents))
          end
        end

        def subcategories(categories)
          option = {
            class: 'dropdown-menu'
          }
          contents = categories.map do |c|
            link = link_to c.name, category_products_path(c)
            content_tag(:li, link)
          end
          content_tag(:ul, safe_join(contents), option)
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

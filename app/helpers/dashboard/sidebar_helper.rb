module Dashboard
  module SidebarHelper
    def admin_side_bar(main_categories)
      Sidebar.new(self, main_categories, params).html
    end
    class Sidebar
      def initialize(view, main_categories, params)
        @view = view
        @params = params
        @main_categories = main_categories
      end

      def html
        categories = main_categories.map { |c| category_tag(c) }
        contents   = categories.unshift(dashboard_tag).push(manage_categories)
        # contents
        content_tag(:ul, safe_join(contents), {class: 'sidebar-nav'})
      end

      private
        include Rails.application.routes.url_helpers

        attr_accessor :view, :main_categories, :params

        delegate :link_to, :content_tag, :safe_join, to: :view

        def dashboard_tag
          link = link_to('Dashboard', admin_path)
          content_tag(:li, link)
        end

        def category_tag(category)
          option = {}
          option[:class] = 'active' if active?(category)
          link           = link_to(category.name, admin_category_products_path(category))
          subcategories  = subcategories_tag(category) if uncollape?(category)
          contents       = content_tag(:li, safe_join([link, subcategories]), option)
        end

        def subcategories_tag(category)
          option = { class: 'list-unstyled' }
          lists = category.subcategories.map { |c| category_tag(c)}
          contents = [content_tag(:ul, safe_join(lists), option)]
          safe_join(contents)
        end

        def manage_categories
          link = link_to('Categories', admin_categories_path)
          content_tag(:li, link)
        end


        def active?(category)
          params[:category_id].to_i ==  category.id
        end

        def parent?(category_id)
          params[:parent_id].to_s ==  category_id.to_s
        end

        def uncollape?(category)
          sub_active = category.subcategories.pluck(:id).include?(params[:category_id].to_i)
          active?(category) || sub_active || parent?(category.id)
        end
    end
  end

end
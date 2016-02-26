module Dashboard
  class AdminController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    def index

    end

    def clear_cache
      Rails.cache.clear
      redirect_to admin_path
    end

  end

end

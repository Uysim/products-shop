class ApplicationController < ActionController::Base
  include ActionController::Caching::Sweeping

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_main_categories

  def set_main_categories
    @main_categories = Category.main_categories
  end
end

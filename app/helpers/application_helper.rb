module ApplicationHelper
  def body_id
    "#{params[:controller].split('/').join('-')}-#{params[:action]}"
  end
  def body_class
    params[:controller].split('/').first
  end
end

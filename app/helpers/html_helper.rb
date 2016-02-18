module HtmlHelper
  def the_title
    if request.host.downcase.include?('gtc')
      "GTC Computer"
    else
      "Glow Tech Cambodia"
    end
  end
end

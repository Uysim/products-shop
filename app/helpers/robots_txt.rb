class RobotsTxt
  def self.call(env)
    # start building a new response
    response = Rack::Response.new

    # set content type to plain txt file
    response['Content-Type'] = 'text/plain'
    # cache the response for one year, so that further requests won't hit
    # the application
    response['Cache-Control'] = 'public, max-age=31557600' # cache for 1 year

    # if we're not in production env, set the content to disallow all robots
    unless Rails.env.production?
      content = ["User-agent: *", "Disallow: /"].join("\n")
      response.write content
    else
      host = env['HTTP_HOST']
      sitemap = "Sitemap: http://#{host}/sitemaps/#{host.parameterize}.xml.gz"
      content = ["User-agent: *", "Disallow:", sitemap].join("\n")
      response.write content
    end

    response.finish
  end
end

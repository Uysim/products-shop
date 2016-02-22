require 'sitemap_generator'
class SiteMap
  def initialize(base_url)
    @base_url = base_url
  end

  def generate
    SitemapGenerator::Sitemap.default_host = "http://#{@base_url}"
    SitemapGenerator::Sitemap.sitemaps_path = "sitemaps"
    SitemapGenerator::Sitemap.filename = @base_url.parameterize
    SitemapGenerator::Sitemap.create do
      Category.all.each do |category|
        add category_products_path(category), changefreq: 'daily', priority: 0.9
        category.products.each do |product|
          add category_product_path(category, product), changefreq: 'weekly', priority: 0.5, lastmod: product.updated_at
        end
      end

      add about_path, changefreq: 'monthly', priority: 0.3
    end
    SitemapGenerator::Sitemap.ping_search_engines
  end


end


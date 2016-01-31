require 'nokogiri'
require 'open-uri'
namespace :feature do
  task run: :environment do
    Category.main_categories.each do |cat|
      feature_products = cat.feature_products
      if feature_products.count < 4
        products = cat.products.limit(4 - feature_products.count)
        products.each do |pro|
          pro.feature = true
          pro.save
        end
      end

    end
  end
end
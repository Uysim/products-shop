require 'nokogiri'
require 'open-uri'
namespace :import do
  task web: :environment do
    @categories = []
    @url = 'http://glowtechcambodia.com'
    @web = Nokogiri::HTML(open(@url))
    categories.each do |category|
      @cat_page = Nokogiri::HTML(open(URI.join(@url, category['href']).to_s))

      @category = Category.new(name: category.text.try(:squish))
      puts "Category #{@category.name} created"
      products.each do |product|
        @page = Nokogiri::HTML(open(URI.join(@url, URI.encode(product['href'])).to_s))
        @product = @category.products.new(name: pro_title, price: pro_price, description: pro_desc)
        @product.fields.new(more_fields)
        @product.images.new(remote_file_url: pro_image_url)
        puts "Product #{@product.name} created"

      end
      # File.open("public/json/#{@category.name}.json","wb") do |f|
      #   f.write(@category.to_json(include: { products: {include: :images} }))
      # end
      sleep 1
      @categories << @category
    end
    puts 'committing'
    @categories.each { |c| c.save }
  end

  def pro_title
    selector = '#k2Container > div.itemHeader > h2'
    @page.css(selector).first.text.try(:squish)
  end

  def pro_price
    selector = '#k2Container > div.itemBody > div.itemExtraFields > ul > li > span.itemExtraFieldsValue'
    price = @page.css(selector).first.text.try(:squish)
    price.gsub('$', '').to_i unless price.nil?
  end

  def pro_desc
    selector = '#k2Container > div.itemBody > div.itemFullText'
    filtered = @page.css(selector).text.split("\n").select{ |obj| !obj.include?(':') }
    filtered.map { |obj| "<p>#{obj.try(:squish)}</p>" }
  end

  def pro_image_url
    selector = '#k2Container > div.itemBody > div.itemImageBlock > span > a > img'
    image    = @page.css(selector).first
    image_url= URI.join(@url, image['src']).to_s
  end

  def more_fields
    selector = '#k2Container > div.itemBody > div.itemFullText'
    filtered = @page.css(selector).text.split("\n").select{ |obj| obj.include?(':') }
    filtered.map { |obj| new_field(obj.try(:squish)) }
  end

  def new_field(string)
    string = string.gsub('-', '')
    arr = string.split(':')
    {
      name: arr[0].try(:squish),
      value: arr[1].try(:squish)
     }
  end

  def products
    selector = '#itemListLeading .itemContainer > div > div.catItemReadMore > a'
    @cat_page.css(selector)
  end

  def categories
    selector = '#k2ModuleBox101 > ul > li > a'
    @web.css(selector)
  end
end
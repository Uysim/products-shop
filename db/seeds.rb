# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless Admin.any?
  Admin.create(email: 'admin@gtc.com',
    password: '12345678',
    password_confirmation: '12345678')
end

main_cats = [
  {
    name: 'Laptop',
    subcategories: ['Accer', 'Dell', 'Mac']
  },
  {
    name: 'Desktop',
    subcategories: ['Accer', 'Dell', 'Mac']
  },
  {
    name: 'Accessories'
  },
  {
    name: 'Printer'
  },
  {
    name: 'Service'
  }
]

main_cats.each do |main|
  c = Category.where(name: main[:name]).first_or_create
  if main[:subcategories]
    main[:subcategories].each do |subcategory|
      c.subcategories.where(name: subcategory).first_or_create
    end
  end
end
Category.all.each_with_index do |cate,index|
  8.times do |i|
    product = cate.products.new(name: "Product-#{index}-#{i}", price: 888)
    desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    product.description = desc
    image = File.open("#{Rails.root}/public/ex.jpg")
    product.images.new(file: image)
    product.fields.new(name: 'CPU', value: '4 GHz')
    product.fields.new(name: 'RAM', value: '16 GB')
    product.fields.new(name: 'Hard Disk', value: '2 TB')
    product.save
  end
end

Category.main_categories.each do |cate|
  cate_ids = cate.subcategories.ids.unshift(cate.id)
  feature_products = Product.of(cate_ids).limit(4)
  feature_products.each { |p| p.update_attributes(feature: true) }
end

slider = Slider.create(name: 'Home')
slider.slider_images.create(file: File.open("#{Rails.root}/public/slider.jpg"))

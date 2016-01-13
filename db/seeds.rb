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
    name: 'Laptop'
    # subcategories: ['Accer', 'Dell', 'Mac']
  },
  {
    name: 'Desktop'
    # subcategories: ['Accer', 'Dell', 'Mac']
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
  10.times do |i|
    cate.products.where(name: "Product-#{index}-#{i}").first_or_create
  end

end
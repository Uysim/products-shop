FactoryGirl.define do
  factory :slider_image do
    file File.open("#{Rails.root}/spec/fixtures/images/ex.jpg")
    link_url "http://www.google.com"
  end

end

FactoryGirl.define do
  factory :image do
    file File.open("#{Rails.root}/spec/fixtures/images/ex.jpg")
  end

end

FactoryGirl.define do
  factory :product do
    name FFaker::Name.name
    price 20
    description FFaker::HTMLIpsum.p
    before(:create) do |product|
      product.images << create(:image)
    end

  end

end

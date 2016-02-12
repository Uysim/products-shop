FactoryGirl.define do
  factory :slider do
    name "slider"
    before(:create) do |slider|
      slider.slider_images << create(:slider_image)
    end
  end

end

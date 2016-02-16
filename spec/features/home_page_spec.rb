describe 'Home Page' do
  let!(:main_category){ create(:category) }
  let!(:category){ create(:category, parent: main_category) }
  let!(:feature_product){ create(:product, feature: true, category: category) }
  let!(:slider){ create(:slider, name: 'Home') }
  subject { page }
  before { visit root_path }

  it { is_expected.to have_link(main_category.name, href: category_products_url(main_category))}
  it { is_expected.to have_link(feature_product.name,href: category_product_path(category, feature_product)) }
  it { is_expected.to have_css("img[src='#{slider.slider_images.first.file.url}']") }
  it { is_expected.to have_link('View More', href: category_products_url(main_category)) }
end

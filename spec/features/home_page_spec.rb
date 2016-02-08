describe 'Home Page' do
  let!(:main_category){ create(:category) }
  let!(:category){ create(:category, parent: main_category) }
  let!(:feature_product){ create(:product, feature: true, category: category) }

  subject { page }
  before { visit root_path }

  it { is_expected.to have_link(main_category.name, href: category_products_url(main_category))}
  it { is_expected.to have_link(feature_product.name,href: category_product_path(category, feature_product)) }




end
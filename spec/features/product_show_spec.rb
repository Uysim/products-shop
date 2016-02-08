describe 'Product Show' do
  let!(:category){ create(:category) }
  let!(:product){ create(:product, category: category) }
  let!(:other_product){ create(:product, category: category) }

  subject { page }
  before { visit category_product_url(category, product) }

  it { is_expected.to have_content(product.name)}
  it { is_expected.to have_css("img[src='#{product.images.first.file.url}']")}
  it { is_expected.to have_link(other_product.name,href: category_product_path(category, other_product)) }

end
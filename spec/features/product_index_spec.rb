describe 'Home Page' do
  let!(:main_category){ create(:category) }
  let!(:category){ create(:category, parent: main_category) }
  let!(:product){ create(:product, category: category) }

  subject { page }


  context 'With sub category' do
    before { visit category_products_url(main_category) }
    it { is_expected.to have_content(main_category.name)}
    it { is_expected.to have_content(category.name) }
    it { is_expected.to have_link(product.name, href: category_product_path(category, product)) }
  end

  context 'Without sub category' do
    before { visit category_products_url(category) }
    it { is_expected.to have_content(category.name) }
    it { is_expected.to have_link(product.name, href: category_product_path(category, product)) }
  end

end
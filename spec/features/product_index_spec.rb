describe 'Product Index' do
  let!(:main_category){ create(:category) }
  let!(:category){ create(:category, parent: main_category) }
  let!(:product){ create(:product, category: category) }
  let!(:nest_category){ create(:category, parent: category) }
  let!(:nest_product){ create(:product, name: 'nest_product', category: nest_category) }

  subject { page }

  context 'Main Category' do
    before { visit category_products_url(main_category)}
    it { is_expected.to have_content(main_category.name)}
    it { is_expected.to have_content(category.name)}
    it { is_expected.to have_link(product.name, href: category_product_path(category, product)) }
    it {save_and_open_page; is_expected.to have_link(nest_product.name, href: category_product_path(nest_category, nest_product)) }
    it { is_expected.to have_link('View More', href: category_products_url(category)) }
  end

  context 'With sub category' do
    before { visit category_products_url(category) }
    it { is_expected.to have_content(category.name)}
    it { is_expected.to have_content(nest_category.name) }
    it { is_expected.to have_link(nest_product.name, href: category_product_path(nest_category, nest_product)) }
  end

  context 'Without sub category' do
    before { visit category_products_url(nest_category) }
    it { is_expected.to have_content(nest_category.name) }
    it { is_expected.to have_link(nest_product.name, href: category_product_path(nest_category, nest_product)) }
  end

end

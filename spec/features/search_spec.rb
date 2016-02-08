describe 'Search Page' do
  let!(:category){ create(:category) }
  let!(:product){ create(:product, category: category) }

  subject { page }
  before do
    visit root_path
    fill_in 'search_query', with: product.name
    click_button("search-button")
    binding.pry
    # save_and_open_page
  end

  it { is_expected.to have_link(product.name,href: category_product_path(category, product)) }

end
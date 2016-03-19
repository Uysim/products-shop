describe 'Product' do
  let(:admin){ create(:admin) }
  let(:category){ create(:category) }
  before do
    login_as(admin)
  end

  feature 'Create' do
    before do
      visit new_admin_category_product_path(category)
    end

    scenario 'valid' do
      fill_in 'Name', with: 'Computer'
      attach_file('File', Rails.root + 'spec/fixtures/images/ex.jpg')
      click_button 'Create Product'
      expect(page).to have_content('Computer')
    end

    xscenario 'invalid' do
      click_button 'Create Product'
      expect(page).to have_content("can't be blank")
    end
  end

  feature 'Edit' do
    let!(:other_category){ create(:category, name: 'Othercategory') }
    let(:product){ create(:product, category: category) }
    before do
      visit edit_admin_category_product_path(category, product)

    end
    scenario 'chagne category' do
      choose(other_category.name, visible: false)
      click_button 'Update Product'
      product.reload
      expect(product.category).to eq(other_category)
    end
  end
end

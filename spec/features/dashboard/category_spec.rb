describe 'Category' do
  let!(:admin){ create(:admin) }
  let!(:parent){ create(:category, name: 'Parent Category') }
  let!(:category){ create(:category) }
  before do
    login_as(admin)
  end
  context 'Chagne Parent' do
    before do
      visit edit_admin_category_path(category)
      choose(parent.name)
      click_button 'Update Category'
    end
    it 'should change parent' do
      category.reload
      expect(category.parent).to eq(parent)
    end
  end
end

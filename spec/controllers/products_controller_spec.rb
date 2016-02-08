describe ProductsController do
  let!(:category){create(:category)}
  let!(:subcategories){create(:category, parent: category)}
  context 'GET #index' do
    before do
      get :index, category_id: category
    end
    it {is_expected.to render_template('index_with_sub')}
  end
end
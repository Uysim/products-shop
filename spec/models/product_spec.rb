describe Product, 'validation' do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:fields) }
  it { is_expected.to have_many(:images) }
  it { is_expected.to accept_nested_attributes_for(:fields) }
  it { is_expected.to accept_nested_attributes_for(:images) }
  it { is_expected.to validate_length_of(:images) }
end


describe Product, 'scope' do
  context 'default scope' do
    let!(:product){ create(:product, sort_order: 1) }
    let!(:other_product){ create(:product, sort_order: 2) }
    let(:products){ Product.all }
    it 'should order by sort order' do
      expect(products).to eq([product, other_product])
    end

    it 'should order by sort order' do
      expect(products).not_to eq([other_product, product])
    end
  end
end

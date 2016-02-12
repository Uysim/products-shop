describe 'Image Thumb' do
  let!(:product){ create(:product) }
  let!(:image){ product.images.first.file }
  it 'should have thumb version' do
    expect(image.thumb).not_to be(nil)
  end
end
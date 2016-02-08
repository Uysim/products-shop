describe Product do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:fields) }
  it { is_expected.to have_many(:images) }
  it { is_expected.to accept_nested_attributes_for(:fields) }
  it { is_expected.to accept_nested_attributes_for(:images) }
  it { is_expected.to validate_length_of(:images) }
end
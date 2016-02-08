describe Category do
  it {is_expected.to belong_to(:parent).class_name('Category')}
  it {is_expected.to have_many(:subcategories).class_name('Category').with_foreign_key('parent_id')}
  it {is_expected.to have_many(:products)}
end
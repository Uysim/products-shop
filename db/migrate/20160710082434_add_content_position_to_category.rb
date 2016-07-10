class AddContentPositionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :content_position, :string
  end
end

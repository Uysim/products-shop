class AddSummaryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :summary, :string
  end
end

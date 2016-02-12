class CreateSliderImages < ActiveRecord::Migration
  def change
    create_table :slider_images do |t|
      t.string :file
      t.string :link_url
      t.references :slider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

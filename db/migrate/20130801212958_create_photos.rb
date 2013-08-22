class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.text :description
      t.boolean :main_photo, default: false
      t.belongs_to :listing
      t.integer :order_priority, default: 0
      t.timestamps
    end
  end
end

class AddOrderToSlideShowImages < ActiveRecord::Migration
  def change
    add_column :slide_show_images, :order, :integer, default: 0
  end
end

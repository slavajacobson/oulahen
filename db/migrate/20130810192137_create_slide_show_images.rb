class CreateSlideShowImages < ActiveRecord::Migration
  def change
    create_table :slide_show_images do |t|
      t.string :image
      t.string :video
      t.string :description_line1
      t.string :description_line2
      t.string :link_to
      t.boolean :active, default: true
      t.boolean :is_video, default: false
      t.timestamps
    end
  end
end

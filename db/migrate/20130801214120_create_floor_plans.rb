class CreateFloorPlans < ActiveRecord::Migration
  def change
    create_table :floor_plans do |t|
      t.string :file
      t.text :description
      t.belongs_to :listing
      t.timestamps
    end
  end
end

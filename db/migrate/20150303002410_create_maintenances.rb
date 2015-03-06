class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
      t.string :label
      t.string :icon

      t.timestamps
    end
  end
end

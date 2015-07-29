class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :url
      t.references :neighbourhood, index: true

      t.timestamps
    end
  end
end

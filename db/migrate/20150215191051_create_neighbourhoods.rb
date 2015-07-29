class CreateNeighbourhoods < ActiveRecord::Migration
  def change
    create_table :neighbourhoods do |t|
      t.string :name
      t.text :description
      #t.text :schools
      t.integer :condo_apts
      t.integer :detached
      t.integer :condo_towns
      t.integer :condo_other
      t.string :image
      t.text :slug, index: true
      t.timestamps
    end
  end
end

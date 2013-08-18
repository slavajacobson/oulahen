class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :street_number
      t.boolean :featured_listing, default: false
      t.boolean :show_street_number, default: true
      t.string :unit_number
      t.string :city_province
      t.boolean :show_unit_number, default: true
      t.string :postal_code
      t.string :neighbourhood
      t.string :lot
      t.integer :sqft
      t.string :bedrooms
      t.string :bathrooms
      t.float :price
      t.boolean :show_price, default: true
      t.boolean :sold
      t.string :transaction_label, default: ''
      t.string :sold_status
      t.float :maintenance_fee
      t.string :virtual_tour_url
      t.string :map_url
      t.string :realtor_url
      t.string :facebook_url
      t.text :description
      t.text :inclusions
      t.text :exclusions
      t.boolean :active, default: true
      t.boolean :draft, default: true
      t.integer :draft_by
      t.integer :priority, default: 1
      t.references :category
      t.timestamps
    end
  end
end

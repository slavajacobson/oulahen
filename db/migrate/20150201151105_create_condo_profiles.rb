class CreateCondoProfiles < ActiveRecord::Migration
  def change
    create_table :condo_profiles do |t|
      t.string :address
      t.date :built_on
      t.integer :floors
      t.integer :units
      t.string :corporation
      t.string :management
      t.string :school_zone
      t.string :distance_from_transit
      t.string :walk_score
      t.integer :total_rented
      t.integer :total_owned
      t.text :slug, index: true
      t.boolean :draft, default: true
      t.integer :draft_by
      t.integer :priority
      t.boolean :active
      t.references :neighbourhood

      t.string :lon
      t.string :lat
      t.string :amenities
      t.timestamps
    end
  end
end

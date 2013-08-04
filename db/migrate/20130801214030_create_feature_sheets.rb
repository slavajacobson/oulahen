class CreateFeatureSheets < ActiveRecord::Migration
  def change
    create_table :feature_sheets do |t|
      t.string :file
      t.text :description
      t.belongs_to :listing
      t.timestamps
    end
  end
end

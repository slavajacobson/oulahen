class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :field_name
      t.string :value
      t.references :team_member
      t.timestamps
    end
  end
end

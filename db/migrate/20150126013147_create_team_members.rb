class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :title
      t.text :bio
      t.text :mini_bio
      t.text :slug, index: true
      t.boolean :draft, default: true
      t.integer :draft_by
      t.timestamps
    end
  end
end

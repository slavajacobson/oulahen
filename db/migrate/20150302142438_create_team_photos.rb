class CreateTeamPhotos < ActiveRecord::Migration
  def change
    create_table :team_photos do |t|
      t.string :image
      t.integer :order
      t.string :description

      t.timestamps
    end
  end
end

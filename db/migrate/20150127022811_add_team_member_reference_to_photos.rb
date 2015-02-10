class AddTeamMemberReferenceToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :team_member, index: true
  end
end

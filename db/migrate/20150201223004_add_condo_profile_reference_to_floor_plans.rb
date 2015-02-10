class AddCondoProfileReferenceToFloorPlans < ActiveRecord::Migration
  def change
    add_reference :floor_plans, :condo_profile, index: true
  end
end

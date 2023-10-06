class AddFacilitatorIdToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :facilitator_id, :integer
  end
end

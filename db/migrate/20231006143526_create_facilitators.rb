class CreateFacilitators < ActiveRecord::Migration[7.0]
  def change
    create_table :facilitators do |t|
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end

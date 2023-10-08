class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end

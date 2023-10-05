class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end

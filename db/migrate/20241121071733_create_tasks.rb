class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.date :due_date, null: false
      t.integer :status, default: 0, null: false  # Use integer for enum
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :description, null: false
      t.integer :writing_gender, null: false, default: 0
      t.date :publication_date, null: false
      t.string :publisher, null: false
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end

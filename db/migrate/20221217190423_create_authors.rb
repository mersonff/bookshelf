class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.integer :writing_gender, default: 0, null: false
      t.integer :age, null: false

      t.timestamps
    end
  end
end

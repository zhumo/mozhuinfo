class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 128
      t.string :phone_number, null: false, limit: 128

      t.index :name, unique: true
      t.index :phone_number, unique: true
      t.timestamps null: false
    end
  end
end

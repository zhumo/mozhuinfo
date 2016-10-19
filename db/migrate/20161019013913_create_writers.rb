class CreateWriters < ActiveRecord::Migration[5.0]
  def change
    create_table :writers do |t|
      t.string :display_name, limit: 128, null: false
      t.string :full_name, limit: 128, null: false
      t.string :password_digest, limit: 128, null: false

      t.timestamps
    end
  end
end

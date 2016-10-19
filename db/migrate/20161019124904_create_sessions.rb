class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :token, limit: 128, null: false

      t.timestamps
    end
  end
end

class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      t.references :contact, null: false
      t.string :algorithm, null: false, limit: 128
      t.string :message, null: false, limit: 128
      t.timestamp :paused_at, null: true
      t.timestamp :next_ping_at, null: true

      t.timestamps null: false
    end
  end
end

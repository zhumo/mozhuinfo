class CreateProgrammaticMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :programmatic_messages do |t|
      t.references :user, null: false
      t.string :algorithm, null: false, limit: 128
      t.string :body, null: false, limit: 128
      t.timestamp :next_message_at, null: true

      t.timestamps null: false
    end
  end
end

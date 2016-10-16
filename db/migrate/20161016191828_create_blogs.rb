class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title, null: false, limit: 256
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end

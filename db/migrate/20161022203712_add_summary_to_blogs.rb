class AddSummaryToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :summary, :string, null: false, limit: 256
  end
end

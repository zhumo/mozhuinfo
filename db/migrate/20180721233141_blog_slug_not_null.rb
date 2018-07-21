class BlogSlugNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column(:blogs, :slug, :string, limit: 128, null: false)
  end
end

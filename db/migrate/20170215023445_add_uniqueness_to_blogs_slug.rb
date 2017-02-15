class AddUniquenessToBlogsSlug < ActiveRecord::Migration[5.0]
  def change
    add_index :blogs, :slug, unique: true
  end
end

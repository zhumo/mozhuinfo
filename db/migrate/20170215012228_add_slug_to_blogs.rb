class AddSlugToBlogs < ActiveRecord::Migration[5.0]
  def up
    add_column :blogs, :slug, :string, limit: 128
    {
      1 => 'whitespace_preservation_haml',
      2 => 'gradual_stiffening',
      3 => 'exor',
      4 => 'quitting_social_media',
    }.each do |id, slug|
      execute(%{
        UPDATE blogs
        SET slug='#{slug}'
        WHERE id='#{id}'
      })
    end
    change_column_null :blogs, :slug, true
  end

  def down
    remove_column :blogs, :slug
  end
end

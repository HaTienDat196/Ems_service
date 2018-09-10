class AddSuggestiveToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :suggestive, :boolean
  end
end

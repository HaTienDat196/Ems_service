class AddCreatorNameToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :creator_name, :string
  end
end

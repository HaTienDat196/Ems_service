class AddCreatorOldToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :creator_old, :int
  end
end

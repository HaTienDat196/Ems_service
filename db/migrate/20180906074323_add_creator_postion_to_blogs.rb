class AddCreatorPostionToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :creator_postion, :string
  end
end

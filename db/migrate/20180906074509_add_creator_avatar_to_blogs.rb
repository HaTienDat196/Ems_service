class AddCreatorAvatarToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :creator_avatar, :string
  end
end

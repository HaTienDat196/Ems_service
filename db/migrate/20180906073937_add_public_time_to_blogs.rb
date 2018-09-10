class AddPublicTimeToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :public_time, :datetime
  end
end

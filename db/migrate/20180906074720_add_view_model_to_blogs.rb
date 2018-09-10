class AddViewModelToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :view_model, :boolean
  end
end

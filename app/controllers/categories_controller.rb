class CategoriesController < ApplicationController
  before_action :category_params

  def category_params
    @category = Category.find_by id: params[:id]
    return unless @category.nil?
    redirect_to root_url
  end
end

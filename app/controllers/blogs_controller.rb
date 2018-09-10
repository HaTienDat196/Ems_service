class BlogsController < ApplicationController
  before_action :find_blog, only: [:edit, :update, :show, :delete]

  def index
    @blog = Blog.all
  end

  def new
    @blog = Blog.new
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog
    else
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :image, :content, :category_id,
                                :created_at, :updated_at, :public_time,
                                :creator_name, :creator_postion,
                                :creator_old, :creator_avatar, :view_model,
                                :suggestive, :category_id)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end
end

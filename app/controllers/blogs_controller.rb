class BlogsController < ApplicationController
  before_action :find_blog, only: [:edit, :update, :show, :delete]

  def index
    @blog = Blog.all
  end

  def new
    @blog = Blog.new
    @categories = Category.all
  end

  # def create
  #   @categories = Category.all
  #   @blog = Blog.new(blog_params)
  #   if edit?
  #     if @blog.valid?
  #       render :preview
  #         if params[:commit] == 'Confirm'
  #           @blog.save
  #         elsif params[:commit] == 'Edit'
  #           render :new
  #         end
  #     else
  #       render :new
  #     end
  #   end
  # end

  # def create
  #   @categories = Category.all
  #   @blog = Blog.new(blog_params)
  #   if params[:commit] == '確認'
  #     render :preview
  #   elsif params[:commit] == 'Comfirm'
  #     @blog.save(blog_params)
  #   else params[:commit] == 'Edit'
  #     render :new
  #   end
  # end


  def create
    @categories = Category.all
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if params[:commit] == '確認'
        format.html { render :preview }
      elsif params[:commit] == 'Edit'
        format.html { render :new }
      elsif @blog.save
        flash[:message] = 'Successfully created blog!'
        format.html { redirect_to blogs_path }
      else
        flash[:alert] = 'Error creating new blog!'
        format.html { render :new }
      end
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
                                :suggestive, :category_id, :category_name)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def edit?
    params[:step] == "edit"
  end

  def preview?
  end
end

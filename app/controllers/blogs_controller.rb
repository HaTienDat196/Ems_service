class BlogsController < ApplicationController

  before_action :find_blog,:find_category_id, only: [:edit, :update, :show, :delete, :updatebolean]

  def index
    @filterrific = initialize_filterrific(
      Blog,
      params[:filterrific],
      select_options: {
        sorted_by: Blog.options_for_sorted_by,
        with_category_name: Category.options_for_select
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [:sorted_by, :with_category_name],
      sanitize_params: true
    ) or return
    @blog = @filterrific.find.page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def new
    @blog = Blog.new
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @blog = Blog.new(blog_params)
    if params[:commit] == 'Edit' && blog_params[:image].present?
      file01 = File.open(Rails.root.join("public" + blog_params[:image]))
      file02 = File.open(Rails.root.join("public" + blog_params[:creator_avatar]))
      @blog.image = file01
      @blog.creator_avatar = file02
    end
    if params[:commit] == 'Confirm' && blog_params.present?
      file01 = File.open(Rails.root.join("public" + blog_params[:image]))
      file02 = File.open(Rails.root.join("public" + blog_params[:creator_avatar]))
      @blog.image = file01
      @blog.creator_avatar = file02
    end

    respond_to do |format|
      if params[:commit] == '確認'
        format.html { render :preview }
      elsif params[:commit] == 'Edit'
        format.html { render :new }
      elsif @blog.save
        flash[:message] = 'ブログを作成しました！'
        format.html { redirect_to blogs_path }
      else
        flash[:alert] = '新しいブログの作成中にエラーが発生しました'
        format.html { render :new }
      end
    end
  end

  def update
    if @blog.update_attributes(blog_params)
      flash[:notice] = "Successfully updated blog!"
      redirect_to blogs_path
      flash[:alert] = "Error update!"
      render :edit
    end
  end

  def edit
  end

  def private_case
      @blog = Blog.find(params[:id])
      @blog.update(view_model: true)
      redirect_to blogs_path
  end

  def public_case
      @blog = Blog.find(params[:id])
      @blog.update(view_model: false)
      redirect_to blogs_path
  end

  def change_publictime
    @blog = Blog.find(params[:id])
    if @blog.public_time.present? == true
     @blog.public_time = @blog.update(public_params)
    end
    redirect_to blogs_path
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :image, :content, :category_id,
                                :created_at, :updated_at, :public_time,
                                :creator_name, :creator_postion,
                                :creator_old, :creator_avatar, :view_model,
                                :suggestive, :category_id, :category_name)
  end

  def public_params
    params.require(:blog).permit(:public_time)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def find_category_id
    @categories = Category.all
  end

  def edit?
    params[:step] == "edit"
  end

  def preview?
  end
end

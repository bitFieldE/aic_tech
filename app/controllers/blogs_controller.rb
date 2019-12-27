class BlogsController < ApplicationController
  before_action :login_required #, only: [:new, :update, :destroy, :like, :unlike]
  before_action :set_blog, only: [:update, :destroy, :unlike]
  before_action :blog_gender_reflection, only: [:show, :like, :unlike]

  # vote like
  def like
    @blog = Blog.readable_for(current_user).find(params[:id])
    current_user.liked_blogs << @blog
    flash.notice = "いいね！しました"
    # delete flash content
    flash.discard if request.xhr?
  end

  # unvote like
  def unlike
    current_user.liked_blogs.destroy(Blog.find(params[:id]))
    flash.notice = "いいね!を取り消しました"
    # delete flash content
    flash.discard if request.xhr?
  end

  # liked users
  def liked
    @blog = Blog.readable_for(current_user).find(params[:id])
    @liked_users = @blog.liked_users.page(params[:page]).per(10)
  end

  # GET /blogs
  # GET /blogs.json
  def index
  #  if current_user
    @blogs = current_user.blogs
  #  else
  #    @blogs = Blog.all
  #  end

    @blogs = @blogs.readable_for(current_user)
      .order(posted_at: :desc).page(params[:page]).per(5)
  end

  def search
    @blogs = current_user.blogs.search(params[:q])
      .page(params[:page]).per(5)
    render "index"
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.readable_for(current_user).find(params[:id])
    @blog_images = @blog.blog_images.page(params[:page]).per(1)
    @test_images = ActiveStorage::Blob.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.author = current_user
    @blog.posted_at = Time.current

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "ブログを投稿しました" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @blog.posted_at = Time.current
    @blog.assign_attributes(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "ブログを更新しました" }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    # In order to realize fast transaction
    # First of all, DELETE blog_images content from blogs
    if @blog.blog_images.attached?
      @blog.blog_images.each do |blog_image|
        blog_image.purge
      end
    end

    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Prophibit the access from same gender
    def blog_gender_reflection
      if current_user && current_user != set_blog.author && set_blog.author.gender == current_user.gender
        redirect_to :account
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(
        :user_id,
        :title,
        :body,
        :posted_at,
        :status,
        blog_images: [],
        new_blog_images: []
      )
    end
end

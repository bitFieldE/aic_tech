class BlogImagesController < ApplicationController
  before_action :login_required

  def destroy
    @blog = current_user.blogs.find(params[:blog_id])
    @blog.blog_images.find_by(blob_id: params[:id]).purge
  end
end

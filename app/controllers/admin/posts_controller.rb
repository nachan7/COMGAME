class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
    @members = Member.all
  end

  def show
    @post = Post.find(params[:id])
    #@post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

end

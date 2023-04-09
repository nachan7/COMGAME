class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    @members = Member.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @posts = Post.all
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end



end

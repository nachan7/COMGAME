class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
    @members = Member.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def member_post
     @post = Post.find(params[:id])
  end
end

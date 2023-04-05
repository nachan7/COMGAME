class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
    @members = Member.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def member_post
    @posts = Post.all
    @post = Post.find(params[:id])
  end
end

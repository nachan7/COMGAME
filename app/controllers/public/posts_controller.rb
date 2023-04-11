class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to posts_path(current_member)
  end

  def index
    @posts = Post.all
    @categories = Category.all
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
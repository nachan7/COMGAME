class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index, :search]
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.score = Language.get_data(post_params[:body])
    if @post.save
      flash[:notice] = "投稿が成功しました"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
    @categories = Category.all
  end

  def search
    @posts = Post.search(params).order(created_at: :desc).page(params[:page])

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
    @post.score = Language.get_data(post_params[:body])
    if @post.update(post_params)
      flash[:notice] = "投稿の編集に成功しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿の削除に成功しました"
      redirect_to posts_path
    else
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :keyword)
  end
  
  def is_matching_login_member
    post = Post.find(params[:id])
    unless post.member_id == current_member.id
      flash[:notice] = "アクセスできません"
      redirect_to member_path(current_member.id)
    end
  end

end
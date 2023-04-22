class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
    @members = Member.all
  end

   def search
    @posts = Post.search(params).order(created_at: :desc).page(params[:page])
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    #@post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿の削除に成功しました"
      redirect_to admin_posts_path
    else
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :keyword)
  end


end

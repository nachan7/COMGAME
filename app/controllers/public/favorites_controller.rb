class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    #redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
    #redirect_to post_path(post)
  end
  
  private
  
end

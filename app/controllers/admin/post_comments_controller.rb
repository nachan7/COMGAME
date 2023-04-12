class Admin::PostCommentsController < ApplicationController

  def destroy
    post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end

end

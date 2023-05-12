class Admin::PostCommentsController < ApplicationController

  #def destroy
   # PostComment.find(params[:id]).destroy
    #redirect_to admin_post_path(params[:post_id])
  #end
  
   def update
    @post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:id])
    post_comment.update(comment: "管理者によって削除されました")
  end

end

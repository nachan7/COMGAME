class Public::HomesController < ApplicationController
  def top
     @posts = Post.all.order("id DESC")
  end

  def about
  end
end

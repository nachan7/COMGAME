class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @post = Post.find(params[:id])
  end

  def edit
    @members = Member.all
    @member = Member.find(params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:name,:email,:is_deleted)
  end
end

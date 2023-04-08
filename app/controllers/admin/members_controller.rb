class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @members = Member.all
    @member = Member.find(params[:id])

  end

  def edit
    @members = Member.all
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member.id)
  end

  def member_post
    @members = Member.all
    @member = Member.find(params[:id])
    @posts = Post.all
  end
  private

  def member_params
    params.require(:member).permit(:name,:email,:is_deleted)
  end
end

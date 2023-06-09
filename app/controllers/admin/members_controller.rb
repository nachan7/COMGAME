class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
     @members = Member.order(created_at: :desc).page(params[:page])
  end

  def search
    @members = Member.search(params[:keyword]).order(created_at: :desc).page(params[:page])
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
    if @member.update(member_params)
      flash[:notice] = "プロフィールの編集に成功しました"
      redirect_to admin_member_path(@member.id)
    else
      render :edit
    end
  end

  def quit_check
    @member = Member.find(params[:id])
  end

  def quit
    member = Member.find(params[:id])
    member.update(is_deleted: true)
    flash[:notice] = "退会させました"
    member.favorites.destroy_all
    member.followings.destroy_all
    member.followers.destroy_all
    member.posts.destroy_all
    member.post_comments.destroy_all
    redirect_to admin_members_path
  end

  #def quit
   # @member = Member.find(params[:id])
    #@member.destroy
    #redirect_to admin_members_path, alert: "会員を削除しました。"
  #end

  def member_post
    @member = Member.find(params[:id])
    @posts = Post.where(member_id:params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:name,:email,:encrypted_password,:profile_image,:introduction,:gender,:playstyle,:gamerank,:voicechat,:playtime,:is_deleted)
  end

end

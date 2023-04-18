class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
     @members = Member.order(created_at: :desc).page(params[:page])
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

  def quit
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to admin_members_path, alert: "会員を削除しました。"
  end

  def member_post
    @member = Member.find(params[:id])
    @posts = Post.where(member_id:params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:name,:email,:encrypted_password,:profile_image,:introduction,:gender,:playstyle,:gamerank,:voicechat,:playtime,:is_deleted)
  end

end

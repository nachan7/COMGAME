class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index]
  

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])

  end

  def favorites
    @member = Member.find(params[:id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_lists = Post.find(favorites)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  def quit_check
    @member = current_member
  end

  def quit
    @member = Member.find(params[:id])
    @member.destroy
    reset_session
    redirect_to root_path, alert: "ご利用誠にありがとうございました。"
  end

  private

  def member_params
    params.require(:member).permit(:name,:email,:encrypted_password,:profile_image,:introduction,:gender,:playstyle,:gamerank,:voicechat,:playtime,:is_deleted)
  end

end
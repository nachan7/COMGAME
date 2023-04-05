class Public::MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = Member.find(params[:id])
    member.update(member_params)
    redirect_to member_path(current_member.id)
  end


  private

  def member_params
    params.require(:member).permit(:name,:email,:encrypted_password,:profile_image_url,:introduction,:gender,:playstyle,:gamerank,:voicechat,:playtime,:is_deleted)
  end

end
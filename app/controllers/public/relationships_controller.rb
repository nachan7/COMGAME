class Public::RelationshipsController < ApplicationController
   before_action :authenticate_member!, except: [:followings,:followers]

  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end


  def followings
    member = Member.find(params[:member_id])
    @members = member.followings.order(created_at: :desc).page(params[:page])
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers.order(created_at: :desc).page(params[:page])
  end

end

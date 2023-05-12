class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:show, :index, :search]
  before_action :is_matching_login_member, only:[:edit, :update, :quit_check]

  def index
    @members = Member.order(created_at: :desc).page(params[:page])
  end

  def search
    @members = Member.search(params[:keyword]).order(created_at: :desc).page(params[:page])
  end

  def show
    @member = Member.find(params[:id])

  end

   def member_post
    @member = Member.find(params[:id])
    @posts = Post.where(member_id:params[:id]).order(created_at: :desc).page(params[:page])
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
    if @member.update(member_params)
      flash[:notice] = "プロフィールの編集に成功しました"
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def quit_check
    @member = current_member
  end

  def quit
    member = Member.find(params[:id])
    member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました"
    member.favorites.destroy_all
    member.followings.destroy_all
    member.followers.destroy_all
    member.posts.destroy_all
    member.post_comments.destroy_all
    member.destroy
    redirect_to root_path
  end

  #def quit
    #@member = Member.find(params[:id])
    #@member.destroy
    #reset_session
    #redirect_to root_path, alert: "ご利用誠にありがとうございました。"
  #end

  private

  def member_params
    params.require(:member).permit(:name,:email,:encrypted_password,:profile_image,:introduction,:gender,:playstyle,:gamerank,:voicechat,:playtime,:is_deleted)
  end

  def is_matching_login_member
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      flash[:notice] = "アクセスできません"
      redirect_to member_path(current_member.id)
    end
  end

end
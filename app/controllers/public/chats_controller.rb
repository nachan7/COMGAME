class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @member = Member.find(params[:id])
    rooms = current_member.member_rooms.pluck(:room_id)
    member_rooms = MemberRoom.find_by(member_id: @member.id, room_id: rooms)

    unless member_rooms.nil?
      @room = member_rooms.room
    else
      @room = Room.new
      @room.save
      MemberRoom.create(member_id: current_member.id, room_id: @room.id)
      MemberRoom.create(member_id: @member.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_member.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    member = Member.find(params[:id])
    unless current_member.following?(member) && member.following?(current_member)
      redirect_to member_path(@member.id)
    end
  end
end

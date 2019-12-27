class ChatRoomsController < ApplicationController
  before_action :login_required
  before_action :match_blocker

  def show
    protect_room(params[:id])
    @chat_room = ChatRoom.find(params[:id])
  end

  def create
    @r = find_room(params[:id])
    @user = User.find_by(id: params[:id])
    if @r
      redirect_to "/users/#{@user.id}/chat_rooms/#{@r.id}}"
    else
      @chat_room = ChatRoom.new(name: "chat_room@#{params[:id]}@#{session[:user_id]}")
      @chat_room.save
      redirect_to "/users/#{@user.id}/chat_rooms/#{@chat_room.id}"
    end
  end

  private

  def match_blocker
    @user = User.find_by(id: params[:user_id])
    redirect_to :matched_relationships unless @user.following?(current_user) && current_user.following?(@user)
  end

  def protect_room(room_id)
    @chat_room = ChatRoom.find room_id
    id = @chat_room.name.split("@")
    unless id.find { |i| i.to_i == session[:user_id].to_i }
      redirect_to users_path
    end
  end

  def find_room(id)
    # In order not to duplicate chatroom
    @room_A = ChatRoom.find_by(name: "chat_room@#{id}@#{session[:user_id]}")
    @room_B = ChatRoom.find_by(name: "chat_room@#{session[:user_id]}@#{id}")
    @r = @room_A || @room_B
    return @r
  end

end

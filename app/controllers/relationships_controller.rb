class RelationshipsController < ApplicationController
  before_action :login_required

  def followers
    @users = current_user.followers.page(params[:page]).per(10)
  end

  def followed
    @users = current_user.following.page(params[:page]).per(10)
  end

  def matched
    @users = current_user.followers.find_all {|follower| current_user.following?(follower) }
    # ここにチャットルームの機能を追加
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    if @user.following?(current_user)
      flash[:notice] = "マッチング成立"
    else
      flash[:notice] = "#{@user.name}さんにいいかもしました!"
    end
    # delete flash content
    flash.discard if request.xhr?
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if @user.following?(current_user)
      @room_A = ChatRoom.find_by(name: "chat_room@#{@user.id}@#{current_user.id}")
      @room_B = ChatRoom.find_by(name: "chat_room@#{current_user.id}@#{@user.id}")
      @chat_room = @room_A || @room_B
      @chat_room.destroy
    end
    current_user.unfollow(@user)
    flash[:notice] = "いいかもリストからはずしました"
    #  delete flash content
    flash.discard if request.xhr?
  end

end

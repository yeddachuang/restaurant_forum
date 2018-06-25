class FriendshipsController < ApplicationController
  def create
    #@friendship = current_user.friends.build(friend_id: params[:friend_id])
    @friendship = Friendship.create(friend_id: params[:friend_id], user_id: current_user.id, status: 1)

    if @friendship.save
      flash[:notice] = "Successfully add friend"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    if @friendship
      @friendship.destroy
      flash[:alert] = "Friendship destroyed"
    else
      flash[:alert] = "No friendship"
    end
    redirect_back(fallback_location: root_path)
  end

  def all_friends
    @friends_sent = current_user.friendships.where(user_id: params[:id])
    @friends_received = current_user.friendships.where(friend_id: params[:id])
    @friends_set = current_user.friendships.where(status: 2)
  end
end

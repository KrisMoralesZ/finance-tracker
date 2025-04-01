class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])

    current_user.add_friend(friend)
    flash[:success] = "Friend added successfully!"

    redirect_to my_friends_path
  end

  def followers
    @followers = Friendship.where(friend_id: current_user.id).includes(:user).map(&:user)
  end

  def destroy
    friend = User.find(params[:id])

    current_user.friends.delete(friend)
    flash[:success] = "Friend removed successfully!"

    redirect_to my_friends_path
  end
end

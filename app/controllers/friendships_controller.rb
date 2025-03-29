class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])

    current_user.add_friend(friend)
    flash[:success] = "Friend added successfully!"

    redirect_to my_friends_path
  end
end

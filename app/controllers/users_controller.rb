class UsersController < ApplicationController
  def my_stocks
    @tracked_stocks = current_user.stocks
  end
end

class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}"
    else
      "Anonymous"
    end
  end

  def add_friend(friend)
    friendships.create(friend_id: friend.id)
  end

  def friend?(user)
    friends.include?(user)
  end

  def under_stocks_limit?
    stocks.count < 5
  end
end

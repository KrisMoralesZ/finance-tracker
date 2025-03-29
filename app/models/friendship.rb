class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "Friendship already exists for this user" }
  validate :cannot_friend_self

  private

  def cannot_friend_self
    errors.add(:friend_id, "You can't friend yourself") if user_id == friend_id
  end
end

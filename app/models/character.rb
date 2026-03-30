class Character < ApplicationRecord
  has_many :user_characters, dependent: :destroy
  has_many :users, through: :user_characters

  def owned_by?(user)
    return false unless user
    user_characters.exists?(user_id: user.id)
  end
end

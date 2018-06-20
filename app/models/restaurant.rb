class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category

  # Restaurant commented by many users
  has_many :comments, dependent: :destroy

  # Restaurant favorited by many users
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # Restaurant liked by many users
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def favorited_inc
    self.favorites_count = self.favorites_count + 1
  end

  def favorited_dec
    self.favorites_count = self.favorites_count - 1
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end
end

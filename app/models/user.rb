class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  mount_uploader :image, AvatarUploader

  # Users has many commented restaurants
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # Users has many favorited restaurants
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # Users has many lked restaurants
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # Users follow many Users
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # Users has many followers
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # Users has many friends
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Users added as friends by many user
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friended, through: :inverse_friendships, source: :user


  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def friended?(user)
    self.friended.include?(user)
  end

  def isfriend?(user)
    friend?(user) & friended?(user)
  end

end

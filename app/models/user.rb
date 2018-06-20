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

  def admin?
    self.role == "admin"
  end
end

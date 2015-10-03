class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true, length: {maximum:225 },
                  format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  validates :age, presence:false,numericality: {only_integer:true, greater_than_or_equal_to: 0,less_than: 100}, on: :update
  validates :comment, presence: false, length: { maximum:100, minimum:0 }, on: :update
  VALID_EMAIL_REGEX = /\Ahttp/
  has_many :microposts
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                   dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  #他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end
  #フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  #あるユーザーをフォローしているかどうか？
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end


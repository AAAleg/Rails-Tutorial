class User < ActiveRecord::Base
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def feed
    Micropost.from_users_followed_by(self)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end

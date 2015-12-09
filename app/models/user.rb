class User < ActiveRecord::Base
  has_secure_password

  has_many :microposts

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

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

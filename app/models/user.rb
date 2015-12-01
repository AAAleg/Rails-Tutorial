class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
end

class User < ActiveRecord::Base
  has_secure_password

  before_save { self.email = email.downcase! }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

end

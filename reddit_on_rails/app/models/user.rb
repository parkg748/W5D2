class User < ApplicationRecord
  attr_reader :password
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :password_digest, :session_token, presence: true
  after_initialize :ensure_session_token
  
  has_many :subs,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Sub
  
  has_many :posts,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Post
  
  has_many :comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end
end

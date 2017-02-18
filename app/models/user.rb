# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 4, allow_nil: true }
  validate :ensure_session_token

  has_many :subs,
    foreign_key: :moderator_id

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.validate_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end

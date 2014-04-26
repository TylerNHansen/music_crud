# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  activated       :boolean          default(FALSE)
#  activate_token  :string(255)
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :activate_token, :session_token, presence: true
  validates :session_token, uniqueness: true
  before_validation :ensure_session_token
  before_validation :make_activate_token

  has_many :notes

  def make_activate_token
    self.activate_token ||= SecureRandom.hex
  end

  def make_session_token!
    self.session_token = SecureRandom.hex
    self.save!
  end

  def self.activate(token)
    User.find_by(activate_token: token).update!(activated: true)
  end

  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    return user if user.try(:is_password?, params[:password])
    nil
  end

  def self.from_session(token)
    self.find_by_session_token(token)
  end

  def password
    nil
  end

  def ensure_session_token
    self.session_token = SecureRandom.hex if self.session_token.nil?
  end

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(plaintext)
    nil
  end

  def is_password?(plaintext)
    BCrypt::Password.new(password_digest).is_password?(plaintext)
  end

end

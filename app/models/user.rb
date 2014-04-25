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
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true


  def make_session_token!
    self.session_token = SecureRandom.hex
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

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(plaintext)
  end

  def is_password?(plaintext)
    BCrypt::Password.new(password_digest).is_password?(plaintext)
  end

end

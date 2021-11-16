class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    filteredEmail = email.strip.downcase
    user = User.where("lower(email) = ?", filteredEmail).first
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end

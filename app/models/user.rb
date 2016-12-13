class User < ActiveRecord::Base

  has_secure_password

  has_many :orders
  has_many :reviewss

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
    uniqueness: true,
    uniqueness: { case_sensitive: false },
    format: { without: /\s/ }
  validates :password, presence: true,
    length: { minimum: 5 }
  validates :password_confirmation, presence: true,
    length: { minimum: 5 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by( "LOWER(email) = ?", email.downcase ).authenticate(password)
  end

end

class User < ActiveRecord::Base
  
  attr_accessor :remember_token, :activation_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  has_many :articles

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :password, length: { minimum: 6 }
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
end

  private

  ## since this method is used internally by the User model, that's why it's being declared as Private
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end

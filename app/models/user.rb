class User < ApplicationRecord
  has_secure_password
  before_create :create_activation_digest
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  private
  def create_activation_digest
    self.api_key = SecureRandom.urlsafe_base64
  end
end

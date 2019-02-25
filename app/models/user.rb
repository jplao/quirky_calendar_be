class User < ApplicationRecord
  has_secure_password
  has_many :favorites
  before_create :create_activation_digest
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  def find_favorites
    fav_holidays = []
    self.favorites.each do |favorite|
      fav_holidays <<Holiday.find(favorite.holiday_id)
    end
    fav_holidays
  end

  private
  def create_activation_digest
    self.api_key = SecureRandom.urlsafe_base64
  end
end

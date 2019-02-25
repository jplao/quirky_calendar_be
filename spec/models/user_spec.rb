require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it {should have_many(:favorites)}
  end

  describe 'instance methods' do
    it 'generates api key on create' do
      params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }

      user = User.create(params)
      expect(user.api_key).not_to be_nil
    end
  end
end

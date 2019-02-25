require 'rails_helper'

describe Favorite, type: :model do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:holiday)}
  end
end

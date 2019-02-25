require 'rails_helper'

describe Holiday, type: :model do
  describe 'relationships' do
    it {should have_many(:favorites)}
  end
end

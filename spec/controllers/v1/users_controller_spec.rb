require 'rails_helper'

describe V1::UsersController do
  let(:user) { Factory.build(:user_stub) }

  describe 'GET token' do
    it 'should create new user' do
      expect(User).to receive(:create!).and_return(user)
      get :token
    end

    it 'should render new token' do
      allow(User).to receive(:create!).and_return(user)
      get :token
      verify { response.body }
    end
  end
end

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create :user }

  context '#current_user' do
    it 'returns the current ser' do
      session[:user_id] = user.id
      expect(current_user).to eq(user)
    end

    it 'not returns the current user' do
      expect(current_user).to be_nil
    end
  end

  context '#user_logged_in?' do
    it 'user logged in' do
      session[:user_id] = user.id
      expect(user_logged_in?).to eq(user)
    end

    it 'user not logged in' do
      expect(user_logged_in?).to be_nil
    end
  end
end

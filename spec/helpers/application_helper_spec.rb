require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create :user }

  context "user unauthenticated" do
    it 'not current user' do
      expect(current_user).to be_nil
    end
    it 'user not logged in' do
      expect(user_logged_in?).to be_nil
    end
  end

  context "user logged in" do
    before(:example) do
      # Create Session
      session[:user_id] = user.id
    end

    it 'current ser' do
      expect(current_user).to eq(user)
    end
    it 'user logged in' do
      expect(user_logged_in?).to eq(user)
    end
  end

end

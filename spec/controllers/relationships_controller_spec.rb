require 'rails_helper'

describe RelationshipsController do
  before do
    user = FactoryGirl.create :michael
    other = FactoryGirl.create :archer
    @relationship = FactoryGirl.create :relationship, follower: user, followed: other
  end

  it 'create should require logged-in user' do
    expect{post :create}.to_not change{Relationship.count}
    expect(response).to redirect_to login_url
  end

  it 'destryoy should require logged-in user' do
    expect{delete :destroy, id: @relationship}.to_not change{Relationship.count}
    expect(response).to redirect_to login_url
  end
end

# require 'test_helper'
#
# class RelationshipsControllerTest < ActionController::TestCase
#   test 'create should require logged-in user' do
#     assert_no_difference 'Relationship.count' do
#       post :create
#     end
#     assert_redirected_to login_url
#   end
#
#   test 'destryoy should require logged-in user' do
#     assert_no_difference 'Relationship.count' do
#       delete :destroy, id: relationships(:one)
#     end
#     assert_redirected_to login_url
#   end
# end

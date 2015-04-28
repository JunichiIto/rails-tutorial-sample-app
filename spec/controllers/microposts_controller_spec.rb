require 'rails_helper'

describe MicropostsController do
  let(:user) { create :michael }
  let!(:micropost) { create :orange, user: user }

  it 'should redirect create when not logged in' do
    expect{post :create, micropost: { content: 'Lorem ipsum' }}.to_not change{Micropost.count}
    expect(response).to redirect_to login_path
  end

  it 'should redirect destroy when not logged in' do
    expect{delete :destroy, id: micropost}.to_not change{Micropost.count}
    expect(response).to redirect_to login_path
  end

  it 'should redirect destroy for wrong micropost' do
    log_in_as(user)
    micropost = create :ants
    expect{delete :destroy, id: micropost}.to_not change{Micropost.count}
    expect(response).to redirect_to root_path
  end
end

# require 'test_helper'
#
# class MicropostsControllerTest < ActionController::TestCase
#   def setup
#     @micropost = microposts(:orange)
#   end
#
#   test 'should redirect create when not logged in' do
#     assert_no_difference 'Micropost.count' do
#       post :create, micropost: { content: 'Lorem ipsum' }
#     end
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect destroy when not logged in' do
#     assert_no_difference 'Micropost.count' do
#       delete :destroy, id: @micropost
#     end
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect destroy for wrong micropost' do
#     log_in_as(users(:michael))
#     micropost = microposts(:ants)
#     assert_no_difference 'Micropost.count' do
#       delete :destroy, id: micropost
#     end
#     assert_redirected_to root_url
#   end
# end

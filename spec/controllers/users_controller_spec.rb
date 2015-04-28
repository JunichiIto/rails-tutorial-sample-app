require 'rails_helper'

describe UsersController do
  before do
    @user = create(:michael)
    @other_user = create(:archer)
  end

  it 'should get new' do
    get :new
    expect(response).to have_http_status(:success)
  end

  it 'should redirect edit when not logged in' do
    get :edit, id: @user
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  it 'should redirect update when not logged in' do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  it 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @user
    expect(flash).to be_empty
    expect(response).to redirect_to root_url
  end

  it 'should redirect index when not logged in' do
    get :index
    expect(response).to redirect_to login_url
  end

  it 'should redirect destroy when not logged in' do
    expect{delete :destroy, id: @user}.to_not change{User.count}
    expect(response).to redirect_to login_url
  end

  it 'should redirect destroy when logged in as non-admin' do
    log_in_as(@other_user)
    expect{delete :destroy, id: @user}.to_not change{User.count}
    expect(response).to redirect_to root_url
  end

  it 'should redirect following when not logged in' do
    get :following, id: @user
    expect(response).to redirect_to login_url
  end

  it 'should redirect followers when not logged in' do
    get :followers, id: @user
    expect(response).to redirect_to login_url
  end
end

# require 'test_helper'
#
# class UsersControllerTest < ActionController::TestCase
#   def setup
#     @user = users(:michael)
#     @other_user = users(:archer)
#   end
#
#   test "should get new" do
#     get :new
#     assert_response :success
#   end
#
#   test 'should redirect edit when not logged in' do
#     get :edit, id: @user
#     assert_not flash.empty?
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect update when not logged in' do
#     patch :update, id: @user, user: { name: @user.name, email: @user.email }
#     assert_not flash.empty?
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect edit when logged in as wrong user' do
#     log_in_as(@other_user)
#     get :edit, id: @user
#     assert flash.empty?
#     assert_redirected_to root_url
#   end
#
#   test 'should redirect update when logged in as wrong user' do
#     log_in_as(@other_user)
#     patch :update, id: @user, user: { name: @user.name, email: @user.email }
#     assert flash.empty?
#     assert_redirected_to root_url
#   end
#
#   test 'should redirect index when not logged in' do
#     get :index
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect destroy when not logged in' do
#     assert_no_difference 'User.count' do
#       delete :destroy, id: @user
#     end
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect destroy when logged in as non-admin' do
#     log_in_as(@other_user)
#     assert_no_difference 'User.count' do
#       delete :destroy, id: @user
#     end
#     assert_redirected_to root_url
#   end
#
#   test 'should redirect following when not logged in' do
#     get :following, id: @user
#     assert_redirected_to login_url
#   end
#
#   test 'should redirect followers when not logged in' do
#     get :followers, id: @user
#     assert_redirected_to login_url
#   end
# end

require 'rails_helper'

describe SessionsController do
  let(:user) { create :michael }

  it 'should get new' do
    get :new
    expect(response).to have_http_status(:success)
  end

  specify 'a user clicking logout in a second window' do
    post :create, session: { email: user.email, password: 'password' }
    expect(response).to redirect_to(user_path(user))
    expect(session).to be_logged_in

    delete :destroy
    expect(response).to redirect_to(root_path)
    expect(session).to_not be_logged_in

    # Simulate a user clicking logout in a second window.
    delete :destroy
    expect(response).to redirect_to(root_path)
  end

  specify 'login with remembering' do
    post :create, session: { email: user.email, password: 'password', remember_me: '1' }
    expect(cookies['remember_token']).to be_present
  end

  specify 'login without remembering' do
    post :create, session: { email: user.email, password: 'password', remember_me: '0' }
    expect(cookies['remember_token']).to be_blank
  end
end

# require 'test_helper'
#
# class SessionsControllerTest < ActionController::TestCase
#   test "should get new" do
#     get :new
#     assert_response :success
#   end
#
# end

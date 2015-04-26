require 'rails_helper'

describe SessionsController do
  it 'should get new' do
    get :new
    expect(response).to have_http_status(:success)
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

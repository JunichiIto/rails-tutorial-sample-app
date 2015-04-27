require 'rails_helper'

describe StaticPagesController do
  it 'should get home' do
    get :home
    expect(response).to have_http_status(:success)
    # Title is tested in features/site_layout_spec.rb
  end

  it 'should get help' do
    get :help
    expect(response).to have_http_status(:success)
  end

  it 'should get about' do
    get :about
    expect(response).to have_http_status(:success)
  end

  it 'should get contact' do
    get :contact
    expect(response).to have_http_status(:success)
  end
end

# require 'test_helper'
#
# class StaticPagesControllerTest < ActionController::TestCase
#   test "should get home" do
#     get :home
#     assert_response :success
#     assert_select 'title', 'Ruby on Rails Tutorial Sample App'
#   end
#
#   test "should get help" do
#     get :help
#     assert_response :success
#     assert_select 'title', 'Help | Ruby on Rails Tutorial Sample App'
#   end
#
#   test "should get about" do
#     get :about
#     assert_response :success
#     assert_select 'title', 'About | Ruby on Rails Tutorial Sample App'
#   end
#
#   test "should get contact" do
#     get :contact
#     assert_response :success
#     assert_select 'title', 'Contact | Ruby on Rails Tutorial Sample App'
#   end
# end

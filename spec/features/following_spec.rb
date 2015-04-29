require 'rails_helper'

feature 'Following' do
  given(:user) { create :michael }
  given(:other) { create :archer }

  background do
    create_relationships(michael: user, archer: other)
    log_in_as user
  end

  scenario 'following page' do
    visit following_user_path(user)
    expect(user.following).to be_present
    expect(page).to have_content user.following.count
    user.following.each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end
  
  scenario 'followers page' do
    visit followers_user_path(user)
    expect(user.followers).to be_present
    expect(page).to have_content user.followers.count
    user.followers.each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end

  scenario 'should follow a user the standard way' do
    visit user_path(other)
    expect { click_button 'Follow' }.to change { user.following.count }.by(1)
  end

  scenario 'should follow a user with Ajax', js: true do
    visit user_path(other)
    expect { click_button 'Follow'; sleep 0.2 }.to change { user.following.count }.by(1)
  end

  scenario 'should unfollow a user the standard way' do
    user.follow(other)
    visit user_path(other)
    expect { click_button 'Unfollow' }.to change { user.following.count }.by(-1)
  end

  scenario 'should unfollow a user with Ajax', js: true do
    user.follow(other)
    visit user_path(other)
    expect { click_button 'Unfollow'; sleep 0.2 }.to change { user.following.count }.by(-1)
  end
end

# require 'test_helper'
#
# class FollowingTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = users(:michael)
#     @other = users(:archer)
#     log_in_as(@user)
#   end
#
#   test 'following page' do
#     get following_user_path(@user)
#     assert_not @user.following.empty?
#     assert_match @user.following.count.to_s, response.body
#     @user.following.each do |user|
#       assert_select 'a[href=?]', user_path(user)
#     end
#   end
#
#   test 'followers page' do
#     get followers_user_path(@user)
#     assert_not @user.followers.empty?
#     assert_match @user.followers.count.to_s, response.body
#     @user.followers.each do |user|
#       assert_select 'a[href=?]', user_path(user)
#     end
#   end
#
#   test 'should follow a user the standard way' do
#     assert_difference '@user.following.count', 1 do
#       post relationships_path, followed_id: @other.id
#     end
#   end
#
#   test 'should follow a user with Ajax' do
#     assert_difference '@user.following.count', 1 do
#       xhr :post, relationships_path, followed_id: @other.id
#     end
#   end
#
#   test 'should unfollow a user the standard way' do
#     @user.follow(@other)
#     relationship = @user.active_relationships.find_by(followed_id: @other.id)
#     assert_difference '@user.following.count', -1 do
#       delete relationship_path(relationship)
#     end
#   end
#
#   test 'should unfollow a user with Ajax' do
#     @user.follow(@other)
#     relationship = @user.active_relationships.find_by(followed_id: @other.id)
#     assert_difference '@user.following.count', -1 do
#       xhr :delete, relationship_path(relationship)
#     end
#   end
# end

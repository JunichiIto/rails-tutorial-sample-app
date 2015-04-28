require 'rails_helper'

feature 'Microposts interface' do
  given(:user) { create :michael }
  given(:other) { create :archer }

  scenario 'micripost interface' do
    log_in_as(user)
    visit root_path
    expect(page).to have_selector('div.pagination')
      .and have_selector('input[type=file]')

    expect{click_button 'Post'}.to_not change{Micropost.count}
    expect(page).to have_selector 'div#error_explanation'

    content = 'This micropost really ties the room together'
    fill_in 'micropost_content', with: content

    picture = 'spec/fixtures/rails.png'
    attach_file 'micropost_picture', picture

    expect{click_button 'Post'}.to change{Micropost.count}.by(1)

    new_micropost = Micropost.unscoped.order(:id).last
    expect(new_micropost.picture?).to be_truthy

    expect(current_path).to eq root_path
    expect(page).to have_content content

    expect(page).to have_link 'delete'
    first_micropost = user.microposts.paginate(page: 1).first
    expect{click_link 'delete', href: micropost_path(first_micropost)}.to change{Micropost.count}.by(-1)

    visit user_path(other)
    expect(page).to_not have_link 'delete'
  end
end

# require 'test_helper'
#
# class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = users(:michael)
#   end
#
#   # See Listing 11.68
#   test 'micropost interface' do
#     log_in_as(@user)
#     get root_path
#     assert_select 'div.pagination'
#     assert_select 'input[type=file]'
#
#     assert_no_difference 'Micropost.count' do
#       post microposts_path, micropost: { content: '' }
#     end
#     assert_select 'div#error_explanation'
#
#     content = 'This micropost really ties the room together'
#     picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
#     assert_difference 'Micropost.count', 1 do
#       post microposts_path, micropost: { content: content, picture: picture }
#     end
#     assert assigns(:micropost).picture?
#     assert_redirected_to root_url
#     follow_redirect!
#     assert_match content, response.body
#
#     assert_select 'a', text: 'delete'
#     first_micropost = @user.microposts.paginate(page: 1).first
#     assert_difference 'Micropost.count', -1 do
#       delete micropost_path(first_micropost)
#     end
#
#     get user_path(users(:archer))
#     assert_select 'a', text: 'delete', count: 0
#   end
# end

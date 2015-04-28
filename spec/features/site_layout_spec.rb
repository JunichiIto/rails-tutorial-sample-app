require 'rails_helper'

feature 'Site layout' do
  scenario 'layout links' do
    visit root_path
    expect(page).to have_selector 'h1', text: 'Welcome to Sample App'
    expect(page).to have_link 'sample app', href: root_path
    expect(page).to have_link 'Home', href: root_path
    expect(page).to have_link 'Help', href: help_path
    expect(page).to have_link 'About', href: about_path
    expect(page).to have_link 'Contact', href: contact_path
  end
end
# require 'test_helper'
#
# class SiteLayoutTest < ActionDispatch::IntegrationTest
#   test 'layout links' do
#     get root_path
#     assert_template 'static_pages/home'
#     assert_select 'a[href=?]', root_path, count: 2
#     assert_select 'a[href=?]', help_path
#     assert_select 'a[href=?]', about_path
#     assert_select 'a[href=?]', contact_path
#   end
# end

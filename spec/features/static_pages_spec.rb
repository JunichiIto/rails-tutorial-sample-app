require 'rails_helper'

feature 'Static pages' do
  scenario 'should visit home' do
    visit root_path
    expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
  end

  scenario 'should visit help' do
    visit help_path
    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end

  scenario 'should visit about' do
    visit about_path
    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end

  scenario 'should visit contact' do
    visit contact_path
    expect(page).to have_title 'Contact | Ruby on Rails Tutorial Sample App'
  end
end
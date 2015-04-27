require 'rails_helper'

describe 'Static pages' do
  it 'should visit home' do
    visit root_path
    expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
  end

  it 'should visit help' do
    visit help_path
    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end

  it 'should visit about' do
    visit about_path
    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end

  it 'should visit contact' do
    visit contact_path
    expect(page).to have_title 'Contact | Ruby on Rails Tutorial Sample App'
  end
end
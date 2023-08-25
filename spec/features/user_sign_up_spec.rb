require 'rails_helper'

RSpec.feature "UserSignUps", type: :feature do
  let(:user_name) { Faker::Name.first_name }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 6) }
  before { visit new_user_registration_path }

  it 'with valid data user should registered' do
    fill_in 'User name', with: user_name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_current_path root_path
  end

  it 'when email already exists user should not registered' do
    user = create(:user)
    fill_in 'User name', with: user_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'Email has already been taken'
  end

  it 'when user_name already exists user should not registered' do
    user = create(:user)
    fill_in 'User name', with: user.user_name
    fill_in 'Email', with: email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'User name has already been taken'
  end

  it 'when password confirmation not match user should not registered' do
    fill_in 'User name', with: user_name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: '111111'
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end

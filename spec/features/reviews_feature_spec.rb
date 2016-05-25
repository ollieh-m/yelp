require 'rails_helper'

feature 'reviewing' do
  before do 
    Restaurant.create(name: 'KFC')
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'email@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'and the review belongs to the user' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(User.find_by(email: 'email@example.com').reviews.count).to eq 1
  end

end
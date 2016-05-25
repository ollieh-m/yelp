require 'rails_helper'

feature 'reviewing' do
  before do
    Restaurant.create name: 'KFC'
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Amazing!"
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Amazing!')
  end

  scenario 'and the review belongs to the user' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Amazing!"
    select '5', from: 'Rating'
    click_button 'Leave Review'
    user = User.find_by(email: 'test@example.com')
    expect(user.reviews.count).to eq 1
  end

  scenario 'user cannot review the same restaurant twice' do
    2.times do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "Amazing!"
      select '5', from: 'Rating'
      click_button 'Leave Review'
    end
    user = User.find_by(email: 'test@example.com')
    expect(user.reviews.count).to eq 1
    expect(Review.all.count).to eq 1
  end

end
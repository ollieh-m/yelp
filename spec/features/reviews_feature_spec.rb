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
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
    expect(Review.all.count).to eq 1

  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(Review.all.count).to eq 1

    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "slightly better"
    select '4', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("has reviewed this restaurant already")
    expect(Review.all.count).to eq 1
    user = User.find_by(email: 'test@example.com')
    expect(user.reviews.count).to eq 1
  end

  context 'deleting reviews' do
    scenario 'a user can delete their own review' do
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'KFC'
      click_link 'Delete Review'
      user = User.find_by(email: 'test@example.com')
      expect(user.reviews.count).to eq 0
    end
    scenario 'a user cannot delete someone elses review' do
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Sign out'
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).to have_content 'You can only delete your own reviews'
      user = User.find_by(email: 'test@example.com')
      expect(user.reviews.count).to eq 1
      expect(Review.all.count).to eq 1
      expect(page).to have_content 'so so'
    end
  end

end

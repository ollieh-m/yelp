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

  scenario 'and the review belongs to the signed in user' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(User.find_by(email: 'email@example.com').reviews.count).to eq 1
  end

  context 'reviewing the same restaurant twice' do
    it 'should not create the second review' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(User.find_by(email: 'email@example.com').reviews.count).to eq 1
      visit '/restaurants'
      expect(page).to have_content('so so', count: 1)
    end
  end

end
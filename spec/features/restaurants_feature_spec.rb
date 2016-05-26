require 'rails_helper'

feature 'restaurants' do

  before(:each) do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end


  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'signed out user can not add restaurants' do
      click_link 'Sign out'
      visit '/restaurants'
      expect(page).not_to have_content('Add a restaurant')
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario 'let a user edit a restaurant' do
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'another user than the user who created the restaurant can not edit' do
      click_link 'Sign out'

      click_link('Sign up')
      fill_in('Email', with: 'another@user.com')
      fill_in('Password', with: 'tacotaco')
      fill_in('Password confirmation', with: 'tacotaco')
      click_button('Sign up')
      # expect(page).not_to have_content 'Edit KFC'
      click_link 'Edit KFC'
      expect(page).to have_content 'You can only edit your own restaurants'
      expect(current_path).to eq '/restaurants'
    end
  end

  context "deleting restaurants" do

    before do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario "let a user delete a Restaurant" do
      visit "/restaurants"
      click_link "Delete KFC"
      expect(page).not_to have_content "KFC"
      expect(page).to have_content "Restaurant deleted successfully"
      expect(current_path).to eq "/restaurants"
    end


    scenario "does not let a user delete a Restaurant it did not create" do
      click_link "Sign out"
      expect(page).not_to have_content "Delete KFC"
      click_link('Sign up')
      fill_in('Email', with: 'another@user.com')
      fill_in('Password', with: 'tacotaco')
      fill_in('Password confirmation', with: 'tacotaco')
      click_button('Sign up')
      # expect(page).not_to have_content "Delete KFC"
      click_link 'Delete KFC'
      expect(page).to have_content 'You can only delete your own restaurants'
      user = User.find_by(email: 'test@example.com')
      expect(user.restaurants.count).to eq 1
    end


  end

  context "an invalid restaurant" do
    it "does not let you submit a name that is too short" do
      visit "/restaurants"
      click_link "Add a restaurant"
      fill_in "Name", with: "kf"
      click_button "Create Restaurant"
      expect(page).not_to have_css "h2", text: "kf"
      expect(page).to have_content "error"
    end
  end

end

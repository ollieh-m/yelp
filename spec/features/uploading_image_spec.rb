require 'rails_helper'

feature 'uploading images' do

	before(:each) do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

	scenario 'user can upload and view an image of a restaurant' do
		click_link 'Add a restaurant'
    fill_in 'Name', with: 'AbraKadabra'
    attach_file('Image', Rails.root + "spec/fixtures/ABRAKABABRA.jpeg")
    click_button 'Create Restaurant'
		expect(page).to have_css("img[src*='ABRAKABABRA.jpeg']")
    expect(current_path).to eq '/restaurants'
    click_link 'AbraKadabra'
		expect(page).to have_css("img[src*='ABRAKABABRA.jpeg']")
	end

end
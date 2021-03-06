require 'rails_helper'

feature 'User can sign in and out' do
	
	context 'A user not signed in and on the homepage' do
		it 'should see a sign-in link and a sign-up link' do
			visit '/'
			expect(page).to have_link('Sign in')
			expect(page).to have_link('Sign up')
		end
		it 'should not see a sign-out link' do
			visit '/'
			expect(page).not_to have_link('Sign out')
		end 
	end

	context 'A user signed in and on the homepage' do
		before do
			visit '/'
			click_link('Sign up')
			fill_in('Email', with: 'email@example.com')
			fill_in('Password', with: 'testtest')
			fill_in('Password confirmation', with: 'testtest')
			click_button('Sign up')
		end
		it 'should see a sign-out link' do
			visit '/'
			expect(page).to have_link('Sign out')
		end
		it 'should not see a sign-in or sign-up link' do
			visit '/'
			expect(page).not_to have_link('Sign in')
			expect(page).not_to have_link('Sign up')
		end
	end

end
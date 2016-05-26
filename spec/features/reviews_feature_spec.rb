require 'rails_helper'

feature 'reviewing' do
  let!(:kfc) { Restaurant.create(name:'KFC') }
  before do
    sign_up
  end

  scenario 'allows users to leave a review using a form' do
   visit '/restaurants'
   click_link 'Review KFC'
   fill_in "Thoughts", with: "so so"
   select '3', from: 'Rating'
   click_button 'Leave Review'

   expect(current_path).to eq "/restaurants"
   expect(page).to have_content('so so')
 end

  scenario 'displays an average rating for all reviews' do
    visit '/restaurants'
    click_link 'Review KFC'
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up(email:"paco@gmail.com",password:"bugmaker", password_confirmation: "bugmaker")
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end



# feature 'reviewing no logged' do
#   let!(:kfc) { Restaurant.create(name:'KFC') }
#   scenario 'can\'t review if not logged in' do
#     visit '/restaurants'
#     click_link 'Review KFC'
#     expect(current_path).to eq "/users/sign_in"
#   end
# end
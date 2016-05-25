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

end

# feature 'reviewing no logged' do
#   let!(:kfc) { Restaurant.create(name:'KFC') }
#   scenario 'can\'t review if not logged in' do
#     visit '/restaurants'
#     click_link 'Review KFC'
#     expect(current_path).to eq "/users/sign_in"
#   end
# end
require 'rails_helper'

feature 'endorsing reviews' do
  before do
  	user = User.create(email: 'test@test.com', password: '123456')
    kfc = Restaurant.create(name: 'KFC', user: user)
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination', user: user)
  end

  it 'a user can endorse a review, which increments the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
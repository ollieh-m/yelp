require 'spec_helper'

describe Review, type: :model do

	it 'should not save a review with a rating more than 5' do
		review = Review.create(rating: 10)
		expect(review).to have(1).error_on(:rating)
		expect(review).not_to be_valid
	end

end
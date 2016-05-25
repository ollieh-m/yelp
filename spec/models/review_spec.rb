describe Review, type: :model do
  it 'rating can\'t be greater than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review_params, current_user)
    Review.create(thoughts: review_params[:thoughts], rating: review_params[:rating], user: current_user, restaurant: self)
  end
end

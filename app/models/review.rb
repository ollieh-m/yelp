class Review < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }

  def owned_by?(current_user)
  	current_user.reviews.include?(self)
  end

end

class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }

  validates :rating, inclusion: (1..5)

  def destroy_if_created_by?(current_user) 
  	if current_user.reviews.include?(self)
  		self.destroy
  	else
  		false
  	end
  end

end

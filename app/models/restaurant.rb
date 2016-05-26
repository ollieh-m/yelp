class Restaurant < ActiveRecord::Base
   has_many :reviews
   belongs_to :user

   validates :name, length: { minimum: 3 }, uniqueness: true

   def build_review(review_params, current_user)
     review_params[:user] = current_user
     self.reviews.build(review_params)
   end

end

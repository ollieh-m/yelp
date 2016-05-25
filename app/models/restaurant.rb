class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy do
    def build_with_user(attributes, user)
      attributes[:user] ||= user
      build(attributes)
    end
  end


  validates :name, length: { minimum: 3 }, uniqueness: true



  # def build_review(review_params, current_user)
  #   review = self.reviews.build(review_params)
  #   review.user = current_user
  #   review
  # end
end

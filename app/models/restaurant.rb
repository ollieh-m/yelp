class Restaurant < ActiveRecord::Base
  belongs_to :user
  # has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  def average_rating
    return "N/A" if reviews.none?
    reviews.average(:rating)
    # sum = 0
    # i = 0
    # reviews.each do |review|
    #   sum += review.rating
    #   i += 1
    # end
    # # p reviews
    # # reviews.average(:rating)
    # return sum/i.to_f

    # p "average: #{reviews.average(:rating)}"
    # return sum/i.to_f
    #
  end

end

class Restaurant < ActiveRecord::Base
  belongs_to :user
  # has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def average_rating
    return "N/A" if reviews.none?
    reviews.average(:rating)
    sum = 0
    i = 0
    reviews.each do |review|
      sum += review.rating
      i += 1
    end
    # p reviews
    # reviews.average(:rating)
    return sum/i.to_f

    # p "average: #{reviews.average(:rating)}"
    # return sum/i.to_f
    #
  end

end

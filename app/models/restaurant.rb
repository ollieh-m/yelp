class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def destroy_if_created_by?(current_user) 
  	if current_user.restaurants.include?(self)
  		self.destroy
  	else
  		false
  	end
  end

  def created_by?(current_user)
  	current_user.restaurants.include?(self)
  end

end

class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews,
  -> { extending WithUserAssociationExtension },
  dependent: :destroy
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
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

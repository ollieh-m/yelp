class Restaurant < ActiveRecord::Base
   has_many :reviews
   belongs_to :user

   validates :name, length: { minimum: 3 }, uniqueness: true
end

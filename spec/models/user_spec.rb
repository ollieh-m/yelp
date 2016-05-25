require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews) }
  it { is_expected.to have_many :reviewed_restaurants }
end

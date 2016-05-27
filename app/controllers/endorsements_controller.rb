class EndorsementsController < ApplicationController

  def create
    p params
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end

end

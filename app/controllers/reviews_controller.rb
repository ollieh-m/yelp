class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: @review.errors
      else
        render :new
      end
    end
  end

  def destroy
    review = Review.find(params[:id])
    unless review.destroy_if_created_by?(current_user) 
      flash[:alert] = 'You can only delete your own reviews'
    end
    redirect_to restaurant_path(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end

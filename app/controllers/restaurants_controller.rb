class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render "new"
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :user_id)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by?(current_user) 
      render 'edit'
    else
      flash[:alert] = 'You can only edit your own restaurants'
      redirect_to '/restaurants'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by?(current_user) 
      @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant updated successfully"
    else
      flash[:alert] = 'You can only edit your own restaurants'
    end
    redirect_to '/restaurants'
  end

 def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy_if_created_by?(current_user) 
      flash[:notice] = "Restaurant deleted successfully"
    else
      flash[:alert] = 'You can only delete your own restaurants'
    end
    redirect_to '/restaurants'
 end

end

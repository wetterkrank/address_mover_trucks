class TrucksController < ApplicationController
  before_action :find_truck, only: [:show, :update, :destroy]

  def index
    @trucks = Truck.all
  end
  
  def show
  end

  def new
    @truck = Truck.new
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.user = current_user
    
    if @truck.save
      redirect_to @truck, notice: 'Your truck was successfully created'
    else
      render:new
    end
  end

  # def destroy
  # end

  private

  def find_truck
    @truck = Truck.find(params[:id])
  end

  def truck_params
    params.require(:truck).permit(:title, :location, :price_per_day, :size, :description)
  end

end

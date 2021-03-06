class TrucksController < ApplicationController
  before_action :find_truck, only: [:show, :update, :edit, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    skip_policy_scope

    if params[:search].present?
      @trucks = Truck.search_by_truck_attributes(params[:search])
    else
      @trucks = Truck.order(created_at: :desc)
    end
    @markers = geocode(@trucks)
  end

  def show
    authorize @truck
    @booking = Booking.new
  end

  def new
    @truck = Truck.new
    authorize @truck
  end

  def create
    new_params = truck_params
    new_params[:price_per_day] = new_params[:price_per_day].to_f * 100 # change the user input to cents for a correcter calculation
    @truck = Truck.new(new_params)
    authorize @truck
    @truck.user = current_user
    if @truck.save
      redirect_to @truck, notice: 'Your truck was successfully created'
    else
      render :new
    end
  end

  def edit
    authorize @truck
  end

  # def destroy
  # end

  private

  # Returns markers for the map
  def geocode(trucks)
    return trucks.geocoded.map do |truck|
      {
        lat: truck.latitude,
        lng: truck.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { truck: truck }),
        image_url: helpers.asset_url('pickup-truck.svg')
      }
    end
  end

  def find_truck
    @truck = Truck.find(params[:id])
  end

  def truck_params
    params.require(:truck).permit(:title, :location, :price_per_day, :size, :description, photos: [])
  end

  def sort_by_created(collection)
    collection.sort_by { |smth| smth.created_at }.reverse
  end

end

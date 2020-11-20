class TrucksController < ApplicationController
  before_action :find_truck, only: [:show, :update, :edit, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  # TODO: This method is getting too long, refactor
  def index
    # Get the list of trucks filtered by the access policy
    @trucks = policy_scope(Truck).order(created_at: :desc)

    # Prepare the markers for the map
    @markers = @trucks.geocoded.map do |truck|
      {
        lat: truck.latitude,
        lng: truck.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { truck: truck }),
        image_url: helpers.asset_url('lorry.png')
      }
    end

    # If index was called with the search parameters
    # this must happen before creating the markers; also, we have a security issue here
    if params[:search]
      @trucks = Truck.search_by_truck_attributes(params[:search])
    else
      @trucks.all
    end
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

  def find_truck
    @truck = Truck.find(params[:id])
  end

  def truck_params
    params.require(:truck).permit(:title, :location, :price_per_day, :size, :description, photos: [])
  end
end

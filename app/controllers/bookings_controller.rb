class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update]

  def index
    # @bookings = Booking.all
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    authorize @booking
  end

  def new
    @truck = Truck.find(params[:truck_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @truck = Truck.find(params[:truck_id])
    @booking.user = current_user
    @booking.truck = @truck
    if @booking.save
      redirect_to booking_path(@booking)
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    @booking.update(booking_params)
    redirect_to booking_path(@booking.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
  
end

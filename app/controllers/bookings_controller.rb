class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = policy_scope(Booking)
    @bookings_as_customer = @bookings.filter { |booking| booking.user == current_user }
    @bookings_as_owner = @bookings.filter { |booking| booking.truck.user == current_user }
  end

  def show
    @truck = @booking.truck
    authorize @booking
  end

  def new
    @truck = Truck.find(params[:truck_id])
    @booking = Booking.new(truck: @truck)
    authorize @booking
  end

  def create
    @truck = Truck.find(params[:truck_id])
    @booking = Booking.new(booking_params)
    @booking.truck = @truck
    @booking.user = current_user
    authorize @booking
    @booking.status = "pending"
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render "trucks/show"
    end
  end

  def edit
    @booking.status = "pending"
    authorize @booking
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      redirect_to booking_path(@booking.id)
    else
      render :edit
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end

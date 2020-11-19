class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = sort_by_created( policy_scope(Booking) )
    @bookings_as_customer = sort_by_created( @bookings.filter { |booking| booking.user == current_user } )
    @bookings_as_owner = sort_by_created( @bookings.filter { |booking| booking.truck.user == current_user } )
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
    end
  end

  def edit
    # @booking.status = "pending"
    authorize @booking
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      if params[:commit] == "Confirm" || params[:commit] == "Decline"
        # if called from the bookings page
        redirect_to bookings_path, notice: "Reservation status updated"
      elsif
        redirect_to booking_path(@booking.id), notice: "Reservation updated"
      end
    else
      # something gone wrong
      render :edit
      # redirect_to booking_path(@booking.id), notice: "Reservation not updated"
    end
    
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path, notice: "Booking deleted"
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def sort_by_created(collection)
    collection.sort_by { |boo| boo.created_at }.reverse
  end

  def finalized?(booking)
    booking.status != "pending"
  end
  helper_method :finalized?

end

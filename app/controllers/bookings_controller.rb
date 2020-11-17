class BookingsController < ApplicationController

    def index
        @bookings = Booking.all
        end

    def show
        @booking = Booking.find(params[:id])
    end
        
        
    def new
        @truck = Truck.find(params[:truck_id])
        @booking = Booking.new
      end
    
      def create
        @booking = Booking.new(booking_params)
        @truck = Truck.find(params[:truck_id])
        @booking.user = current_user
        @booking.truck = @truck
        if @booking.save
          redirect_to booking_path(@booking)
        end
      end

      def edit
        @booking = Booking.find(params[:id])
      end

      def update
        @booking = Booking.find(params[:id])
        @booking.update(booking_params)
        redirect_to booking_path(@booking.id)
      end
    
      private
    
      def booking_params
        params.require(:booking).permit(:status, :start_date, :end_date)
      end
    
    
    
end

class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      # Must return the "filtered" array of Scope (i.e. Booking) instances
      if user.admin?
        scope.all
      else
        # You can only see the bookings where you are the customer
        # OR
        # The bookings that you are the owner of the offer
        bookings_user_is_customer = scope.where(user: user)
        bookings_user_is_owner = scope.joins(:truck).where(trucks: { user: user })
        # Note: the result is an Array, not AR:Relation:
        bookings_user_is_customer + bookings_user_is_owner
      end
    end
  end

  def create?
    true
  end

  def show?
    # Show booking only to buyer/seller sides or admin
    user == record.user || user == record.truck.user || user_is_admin?
  end

  def update?
    # Allow this only to the buyer/seller (truck owner) or admin
    user == record.user || user == record.truck.user || user_is_admin?
  end

  def destroy?
    # Only admin can delete bookings
    user_is_admin?
  end

  private

  def user_is_admin?
    user.admin
  end

end

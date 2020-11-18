class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      # Show the full list of bookings only to admin?
      scope.all
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
    # Allow this only to the seller (truck owner) or admin
    user == record.truck.user || user_is_admin?
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

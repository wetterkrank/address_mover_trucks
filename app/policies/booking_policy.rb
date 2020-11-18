class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      # Show the full list of bookings only to admin?
      scope.all
    end
  end

  def create?
    # Truck owner can't book own truck
    # Fancy way from https://github.com/andrerferrer/pundit-outsourcing-demo
    TruckPolicy.new(user, record.truck).not_owner? || user_is_admin?
    # user != record.truck.user || user_is_admin?
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


  def user_is_admin?
    user.admin
  end

end

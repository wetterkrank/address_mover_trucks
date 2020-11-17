class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  
  def create?
    true
  end

  def show?
    true
  end

  def update?
    # Allow this only to the seller (truck owner)
    user == record.truck.user
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    user.admin
  end

end

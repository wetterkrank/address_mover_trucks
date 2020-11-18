class TruckPolicy < ApplicationPolicy

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
    # Allow this only to the seller (truck owner) or admin
    user_is_owner? || user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    user.admin
  end

  def user_is_owner?
    user == record.user
  end

end

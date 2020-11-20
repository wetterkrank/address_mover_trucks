class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # We can limit the number of results here and perhaps sort them by rating (if we have reviews)
    @trucks = policy_scope(Truck).order(created_at: :desc)
  end
end

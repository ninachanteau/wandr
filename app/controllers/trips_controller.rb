class TripsController < ApplicationController
  def index
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
  end
end

class TripsController < ApplicationController
  def index
    @trips = current_user.future_trips
    @past_trips = current_user.past_trips
  end
end

class Trips::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @current_participation = Participation.find_by_token(params[:token])
    @trip = Trip.find(params[:id])
  end
end

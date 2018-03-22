require "open-uri"
require "nokogiri"

class Participations::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  def create
  @trip = Trip.find(params[:trip_id])
  @user = User.find_by_email(@participation.email)
  @participation = Participation.new(participation_params)
  @participation.trip = @trip
  @pseudo = @participation.pseudo
  if @user.present?
    @participation.user = @user
    @participation.pseudo = @participation.user.first_name
    @participation.avatar = @participation.user.avatar
  else
    @participation.avatar = image_tag("default-user.png")
    if @participation.pseudo.present?
      @participation.pseudo = @pseudo
    else
      @participation.pseudo = "you"
    end
  end
  @participation.save
  redirect_to trip_path(@trip)
end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :pseudo, :email)
  end



end

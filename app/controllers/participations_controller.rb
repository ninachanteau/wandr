class ParticipationsController < ApplicationController

def create
  @trip = Trip.find(params[:trip_id])
  @participation = Participation.new(participation_params)
  @user = User.find_by_email(@participation.email)
  @participation.trip = @trip
  @pseudo = @participation.pseudo
  if @user.present?
    @participation.user = @user
    @participation.pseudo = @participation.user.first_name
    @participation.avatar = @participation.user.avatar
  else
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

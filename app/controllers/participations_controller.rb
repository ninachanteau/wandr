class ParticipationsController < ApplicationController

def create
  @trip = Trip.find(params[:trip_id])
  @participation = Participation.new(participation_params)
  @participation.trip = @trip
  @pseudo = @participation.pseudo
  if @participation.pseudo == "" || @participation.pseudo.nil?
    if User.find_by_email(@participation.email).nil?
      @participation.pseudo = "You"
    else
      @participation.user = User.find_by_email(@participation.email)
      @participation.pseudo = @participation.user.first_name
    end
  else
    @participation.pseudo = @pseudo
  end
  if @participation.save
    redirect_to trip_path(@trip)
  end
end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :pseudo, :email)
  end

end

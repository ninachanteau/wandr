class ParticipationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.participation_mailer.join_trip.subject
  #
  def join_trip(participation)  # Instance variable => available in view
    @participation = participation
    mail(to: @participation.email, subject: 'Join a trip')
  end
end

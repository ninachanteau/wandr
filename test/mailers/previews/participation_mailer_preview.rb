# Preview all emails at http://localhost:3000/rails/mailers/participation_mailer
class ParticipationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/participation_mailer/join_trip
  def join_trip
    ParticipationMailer.join_trip
  end

end

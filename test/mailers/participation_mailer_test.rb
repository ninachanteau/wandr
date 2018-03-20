require 'test_helper'

class ParticipationMailerTest < ActionMailer::TestCase
  # test "join_trip" do
  #   mail = ParticipationMailer.join_trip
  #   assert_equal "Join trip", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end
  def join_trip
    participation = Participation.first
    UserMailer.join_trip(participation)
  end

end

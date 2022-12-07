# Preview all emails at http://localhost:3000/rails/mailers/user_notifier_mailer
class UserNotifierMailerPreview < ActionMailer::Preview
  def send_booking_email
    UserNotifierMailer.send_booking_email(User.first, Booking.first)
  end
end

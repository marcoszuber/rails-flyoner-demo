class UserNotifierMailer < ApplicationMailer
  default :from => 'noreply@flyoner.me'

  def send_booking_email(user, booking)
    @user = user
    @booking = booking
    attachments.inline['logof.png'] = File.read('app/assets/images/logof.png')
    mail( :to => @user.email,
    :subject => 'Thanks for booking with Flyoner' )
  end
end

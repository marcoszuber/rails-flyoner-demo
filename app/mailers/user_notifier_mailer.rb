class UserNotifierMailer < ApplicationMailer
  default :from => 'noreply@flyoner.me'

  def send_booking_email(user)
    @user = user
    attachments.inline['default.png'] = File.read('app/assets/images/default.png')
    mail( :to => @user.email,
    :subject => 'Thanks for booking with Flyoner' )
  end
end

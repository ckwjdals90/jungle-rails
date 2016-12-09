class UserMailer < ApplicationMailer
  default from: 'noreply@jungle.com'

  def welcome_email(order)
    @user = 'ckwjdals90@gmail.com'
    @url  = 'http://localhost:3000/login'
    mail(to: @user, subject: 'Thank you for shopping with us!')
  end
end

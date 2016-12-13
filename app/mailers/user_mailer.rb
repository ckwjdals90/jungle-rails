class UserMailer < ApplicationMailer
  default from: 'noreply@jungle.com'

  def order_confirmation_email(order)
    @order = order
    @user = 'ckwjdals90@gmail.com'
    @url  = 'http://localhost:3000/login'
    mail(to: @user, subject: "Order Confirmation for: ##{@order.id} Thank you for shopping with us!")
  end
end

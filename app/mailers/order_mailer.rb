class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.complete.subject
  #
  def complete(order, order_detail)
    @order = order
    @OrderDetail  = order_detail

    email = @order.email

    mail(to: email, subject: 'Your order has been completed')
  end
end

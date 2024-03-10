# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.complete.subject
  #
  def complete(order)
    @order = order

    @email = @order.email

    Rails.logger.debug "email: #{@email}"

    mail(to: @email, subject: 'Your order has been completed')
  end
end

class InquiryMailer < ApplicationMailer
  default from: email_address_with_name('notifications@example.com', '購入のお知らせの例')

  def welcome_email
    @user = params[:user]
    @url = 'http://example.com/login'
    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: 'welcome to my site.'
    )
  end
end

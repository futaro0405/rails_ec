class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'amb2eme6@gmail.com',
      to: 'fkswtkm0405@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end

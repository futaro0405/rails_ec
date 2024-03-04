# Preview all emails at http://localhost:3000/rails/mailers/inquiry
class InquiryPreview < ActionMailer::Preview
  def welcome_email
    InquiryMailer.with(user: User.first).welcome_email
  end
end

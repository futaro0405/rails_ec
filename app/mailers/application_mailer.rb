# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # default from: Rails.application.credentials.gmail[:email]
  default from: ''
  layout 'mailer'
end

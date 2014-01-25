class UserMailer < ActionMailer::Base
  default from: "oulahen@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact_form.subject
  #
  def contact_form(name, email, phone, message, recipient)
    @message = message
    @phone = phone
    @email = email
    @name = name
    @recipient = recipient
    
    recipients = ["team"]

    recipients << recipient unless recipient.blank?


    


    mail to: recipients.map { |user| "#{user}@oulahen.com" }, subject: "Website Contact Form"

  end
end

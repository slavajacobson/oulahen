class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact_form.subject
  #
  def contact_form(name, email, phone, message)
    @message = message
    @phone = phone
    @email = email
    @name = name

    mail to: "slava.jacobson@gmail.com", from: "vs.jacobson@gmail.com", subject: "Website Contact Form"
  end
end

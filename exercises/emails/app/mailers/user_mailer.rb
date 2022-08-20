# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation
    # BEGIN
    @user = params[:user]
    mail(from: ENV.fetch('MAIL_USERNAME', 'example@mail.com'), to: @user.email, subject: t('.confirm'))
    # END
  end
end

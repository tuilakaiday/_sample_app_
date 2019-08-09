class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: "exem@mail.com", Subject: "Account activation of SampleApp"
  end
end

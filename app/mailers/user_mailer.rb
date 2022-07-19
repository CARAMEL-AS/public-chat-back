class UserMailer < ApplicationMailer

    default from: 'no-reply@chat-app.com'

    def verify_email
        @user = params[:user]
        @code = params[:code]
        mail(to: @user.email, subject: 'Verify your email!')
    end

end

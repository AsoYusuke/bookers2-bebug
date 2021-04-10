class ThanksMailer < ApplicationMailer
  default from: 'notifications@example.com'

 def thanks_email
   @user = params[:user]
   mail(to: @user.email, subject: '登録完了メール')
 end
end

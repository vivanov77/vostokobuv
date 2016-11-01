class NewsMailer < ApplicationMailer

	default from: Rails.application.secrets.YANDEX_LOGIN

  # NewsMailer.welcome(@user).deliver_now

  def shoes_news(user)
  	@user = user
  	@shoes = Shoe.all
  	mail(to: @user.email, subject: 'Почтовая рассылка по обуви')
  end

end

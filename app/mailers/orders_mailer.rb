class OrdersMailer < ApplicationMailer

  # OrdersMailer.order_notification(order, user).deliver_now

  def order_notification(order, user)

  	@order = order

  	@user = user if user

  	mail(to: secret_key("ORDERS_MAIL"), subject: 'Сделан заказ')

  end

end

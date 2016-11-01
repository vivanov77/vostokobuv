
namespace :vo do

  desc 'Почтовая рассылка'
  task send: :environment do
    send_letter
  end

  def send_letter

    users = User


    NewsMailer.shoes_news(@user).deliver_now

  

    news = News.where(created_at: (from..to)).order(:created_at).all
    events = Event.where(created_at: (from..to)).order(:created_at).all

    news_dates = news.group_by { |param| param.created_at.beginning_of_day }
    events_dates = events.group_by { |param| param.created_at.beginning_of_day }
    
    @application_host = Rails.application.secrets.MAILER_APPLICATION_HOST

    if news.any? or events.any?

      av = ActionView::Base.new(Rails.configuration.paths["app/views"])
      
      av.class_eval { include Rails.application.routes.url_helpers }

      body_news   = ""
      body_events = ""

      body_news   = av.render partial: "/news/mail", format: :txt, locals: {news_list: news_dates, host: @application_host, section: 'Новости'} if news.any?
      body_events = av.render partial: "/news/mail", format: :txt, locals: {news_list: events_dates, host: @application_host, section: 'События'} if events.any?
      
      delivery = Delivery.new subject: DeliveryMailer.subscription_title(date_base, period), body: body_news + body_events,
      delivery_type: period
      
      if delivery.save
        delivery.run!

        subscriptions = Delivery::Subscription.confirmed.where(subscription_type: period).all
        subscriptions.each do |subscription|
          DeliveryMailer.generic(delivery, subscription).deliver_now
        end
        delivery.finish!
      else
        # error - not saved
        delivery.stop!
      end
    end

    expiration_date = DateTime.yesterday - 4.months

    Delivery.delete_all(["created_at < ?", expiration_date]) # destroy_all not necessary

  end
end
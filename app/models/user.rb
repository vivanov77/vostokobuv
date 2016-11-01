class User < ApplicationRecord

  has_many :shoes
  has_many :opinions

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image 

  has_many :user_news
  accepts_nested_attributes_for :user_news
# http://stackoverflow.com/questions/2799746/habtm-relationship-does-not-support-dependent-option  
  # before_destroy { articles.destroy }  
  # after_destroy { User.find(:all, :uniq => true, :joins => :articles, :conditions => 'articles.id is NULL').each(&:destroy) }

  has_and_belongs_to_many :orders
# http://stackoverflow.com/questions/2799746/habtm-relationship-does-not-support-dependent-option  
  # before_destroy { orders.destroy }

  # validates :first_name, :middle_name, :last_name, :phone, :organization, :city, :address, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable,
# http://stackoverflow.com/questions/8186584/how-do-i-set-up-email-confirmation-with-devise         
         :omniauth_providers => [:facebook, :vkontakte]

# https://github.com/plataformatec/devise/wiki/How-To:-Send-devise-emails-in-background-(Resque,-Sidekiq-and-Delayed::Job)
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end         

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.from_omniauth_vkontakte(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # user.email = auth.info.email
# https://habrahabr.ru/post/142128/     

# logger.debug auth

      # user.email = auth.extra.raw_info.id.to_s + '@vk.com'
      user.email = auth.extra.raw_info.first_name.to_s + "." + auth.extra.raw_info.last_name.to_s + '@vk.com'      
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end  

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  # ----

  # attr_accessor :email, :password, :password_confirmation, :remember_me
  # attr_accessor :nickname, :provider, :url, :username         
 
  # def self.find_for_vkontakte_oauth access_token
  #   if user = User.where(:url => access_token.info.urls.Vkontakte).first
  #     user
  #   else 
  #     User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => access_token.extra.raw_info.domain+'<hh user=vk>.com', :password => Devise.friendly_token[0,20]) 
  #   end
  # end

  after_destroy :ensure_an_admin_remains
     
  def admin?
    admin
  end

  def blocked?
    blocked
  end
  
 private

  def ensure_an_admin_remains 
    if User.where("admin = ?", true).count.zero?
      raise "Не могу удалить последнего админа"
    end
  end    

end

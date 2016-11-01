class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_up
  def new
    # if Rails.env.production?
      redirect_back(fallback_location: root_path, notice: "Регистрация временно отключена.") and return
    # end
    super
  end

  # POST /resource
  def create

    if Rails.env.production?
      redirect_back(fallback_location: root_path, notice: "Регистрация временно отключена.") and return
    end

    if params[:grecaptcha].blank?

      redirect_back(fallback_location: root_path, notice: "Вы не ввели каптчу.") and return

    end

    grecaptcha = param2hash(params[:grecaptcha])[0.to_s]
 
    status = verify_google_recptcha(secret_key('RECAPTCHA_PRIVATE_KEY'), grecaptcha)

    if status

      super

    else
# http://stackoverflow.com/questions/2139996/how-to-redirect-to-previous-page-in-ruby-on-rails      
      redirect_back(fallback_location: root_path, notice: "Вы ввели неправильную каптчу.") 
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :middle_name, :last_name, :phone, :organization, :city, :address])
  end  

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
# https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
    
end

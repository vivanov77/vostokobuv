class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create  
    begin 
    if User.find_by_email(params[:user][:email]).blocked?
      sign_out
      redirect_to store_path, notice: "Ваша учётная запись была заблокирована. Вы не можете войти."   
      else
        super
    end
    rescue # if there is no such user then nil.blocked? fires an exception
    super
    end
  end  

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

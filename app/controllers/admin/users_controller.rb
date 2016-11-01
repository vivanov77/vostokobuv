class Admin::UsersController < Admin::ApplicationController
#class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_filter :require_no_authentication
  #before_filter :authenticate_user!, except: [:show, :index]
  # before_filter :authenticate_user!
  # load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  #def new
  #  @user = User.new
  #end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  #def create
  #  @user = User.new(user_params)
  #
  #  respond_to do |format|
  #   if @user.save
  #     format.html { redirect_to @user, notice: 'User был успешно создан.' }
  #     format.json { render :show, status: :created, location: @user }
  #   else
  #     format.html { render :new }
  #     format.json { render json: @user.errors, status: :unprocessable_entity }
  #   end
  # end
  #end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        # if params[:image]
        #   @image_attachment = @user.image.build(:file => params[:image]['file'], :imageable_id => @user.id, :imageable_type => @user.class.name)
        #   @user.image = @image_attachment
        #   @user.save!
        # end        
        format.html { redirect_to [:admin, @user], notice: 'Пользователь был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  
    begin
      @user.destroy
      flash[:notice] = 'Пользователь был успешно удалён.'
    rescue Exception => e
      flash[:notice] = e.message
    end
	
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User был успешно удалён.' }
	  format.html { redirect_to admin_users_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :admin, :blocked, :first_name, :middle_name, :last_name, :organization, :city, :address, :producer, :subscribe_news, :url_name, :description, :contact, :delivery_info, image_attributes: ["file", "@original_filename", "@content_type", "@headers"])
    end
end

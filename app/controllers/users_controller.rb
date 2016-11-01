class UsersController < ApplicationController
#class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_filter :require_no_authentication
  #before_filter :authenticate_user!, except: [:show, :index]
  # before_filter :authenticate_user!
  # load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # after_action :set_layout, only: [:show]

  # GET /users
  # GET /users.json
  def index

    @producers = User.where(producer: true).order(:organization)

  end

  # GET /users/1
  # GET /users/1.json
  def show

    @shoes = Shoe.where(user_id: @user.id).order(:title)

    @filters = CategoryType

    if user_params[:categories]

      # @shoes = shoes.where("categories ->> '12' = '23' AND categories ->> '13' = '19'")
      
      @categories_st = ""

      user_params[:categories].each_pair {|key, value| @categories_st << "categories ->> '#{key}' = '#{value}' AND " }

      @categories_st = @categories_st.slice(0, @categories_st.length - 5)

      @shoes = @shoes.where(@categories_st)

    end      
   
    @shoes = @shoes.order(:title)

    @filters = @filters.order(:title)   

    @categories = params[:categories]

    @producers = User.where(producer: true).order(:organization)

    set_layout

  end

  # GET /users/new
  #def new
  #  @user = User.new
  #end

  # GET /users/1/edit
  def edit
    @type = params[:type]
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
        # format.html { redirect_to @user, notice: 'User был успешно обновлён.' }
        # if params[:image]
        #   @image_attachment = @user.image.build(:file => params[:image]['file'], :imageable_id => @user.id, :imageable_type => @user.class.name)
        #   @user.image = @image_attachment
        #   @user.save!
        # end

        if params[:type] == "user_news"
          format.html { redirect_back(fallback_location: @user, notice: 'Пользователь был успешно обновлён.') }
        elsif params[:type] == "new_user_news"
          format.html { redirect_to edit_user_path(@user, type: :user_news), notice: 'Пользователь был успешно обновлён.' }        
        else
          format.html { redirect_to edit_user_path(@user, type: :data), notice: 'Пользователь был успешно обновлён.' }
          format.json { render :show, status: :ok, location: @user }
        end
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
	    format.html { redirect_to users_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      
      @business_card

      if params[:business_card]

        unless params[:business_card].include? "user_news"

          @business_card = params[:business_card]

          @user = User.where(producer: true).find_by(url_name: @business_card)

          unless @user
            redirect_to root_url and return
          end

        end

      else
        @user = User.find(params[:id])
      end       

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
#       params.require(:user).permit(:email, :first_name, :middle_name, :last_name, 
#         :organization, :city, :address, :producer, 
#         :url_name, :description, :contact, :delivery_info, :type,
#         :phone, :subscribe_news_shoes, :subscribe_news_components,
# # http://edgeapi.rubyonrails.org/classes/ActionController/StrongParameters.html        
#         :business_card, :url_name_active, articles_attributes: [:id, :content],
#         image_attributes: ["file", "@original_filename", "@content_type", "@headers"])

      new_params = params

      if new_params[:categories]

        new_params = new_params.merge({
          categories: (new_params[:categories]).delete_if { |k, v| v.empty? }
          })

      end

      if new_params[:user]

#       new_params.require(:user).permit(:email, :first_name, :middle_name, :last_name, 
#         :organization, :city, :address, :producer, 
#         :url_name, :description, :contact, :delivery_info, :type,
#         :phone, :subscribe_news_shoes, :subscribe_news_components,
# # http://edgeapi.rubyonrails.org/classes/ActionController/StrongParameters.html        
#         :business_card, :url_name_active, articles_attributes: [:id, :content],
#         image_attributes: ["file", "@original_filename", "@content_type", "@headers"])

        new_params = new_params.require(:user).permit!

      end

      new_params

      # params.require(:user).permit!
       
    end
end

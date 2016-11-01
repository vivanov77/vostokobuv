class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  before_action :check_captcha, only: [:create]

  before_action :remember_current_page, only: [:new]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new

    if current_user
# http://stackoverflow.com/questions/4907068/how-do-i-remove-repeated-spaces-in-a-string
      @order.name = (repnil(current_user.first_name,"_")  + " " + repnil(current_user.middle_name,"_") + " " + repnil(current_user.last_name,"_")).squish

      @order.city = current_user.city      

      @order.email = current_user.email

      @order.phone = current_user.phone

      # @order.users << current_user

    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save && ( current_user ? @order.users << current_user : true )

        OrdersMailer.order_notification(@order, current_user).deliver_later

        # format.html { redirect_to @order, notice: 'Заявка была успешно создана.' }
        # format.html { redirect_to root_path, notice: 'Заявка была успешно создана.' }
        format.html { redirect_to (session[:return_to].blank? ? root_path : session[:return_to]), notice: 'Заявка была успешно создана.' }        
        # format.html { redirect_back(fallback_location: root_path, notice: 'Заявка была успешно создана.') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Заявка была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Заявка была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:title, :content, :name, :city, :email, :phone)
    end

    def check_captcha

      if params[:grecaptcha].blank?

        redirect_back(fallback_location: root_path, notice: "Вы не заполнили проверку \"Я не робот\").") and return

      end

      grecaptcha = param2hash(params[:grecaptcha])[0.to_s]
   
      status = verify_google_recptcha(secret_key('RECAPTCHA_PRIVATE_KEY'), grecaptcha)

      if status

        # super

      else
  # http://stackoverflow.com/questions/2139996/how-to-redirect-to-previous-page-in-ruby-on-rails      
        redirect_back(fallback_location: root_path, notice: "Вы неправильно заполнили проверку \"Я не робот\".") 
      end      

    end

    def remember_current_page

      # p request.original_url
# http://stackoverflow.com/questions/3304597/rails-redirect-two-pages-back
      session[:return_to] = request.referer

    end
end

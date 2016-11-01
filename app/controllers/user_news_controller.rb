class UserNewsController < ApplicationController
  before_action :set_user_news, only: [:show, :edit, :update, :destroy]

  # GET /user_news
  # GET /user_news.json
  def index
    @user_news = UserNews.all
  end

  # GET /user_news/1
  # GET /user_news/1.json
  def show
    render :layout => false
  end

  # GET /user_news/new
  def new
    @user_news = UserNews.new
  end

  # GET /user_news/1/edit
  def edit
  end

  # POST /user_news
  # POST /user_news.json
  def create
    @user_news = UserNews.new(user_news_params)

    respond_to do |format|
      if @user_news.save
        format.html { redirect_to @user_news, notice: 'Пользовательская новость была успешно создана.' }
        format.json { render :show, status: :created, location: @user_news }
      else
        format.html { render :new }
        format.json { render json: @user_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_news/1
  # PATCH/PUT /user_news/1.json
  def update
    respond_to do |format|
      if @user_news.update(user_news_params)
        format.html { redirect_to @user_news, notice: 'Пользовательская новость была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @user_news }
      else
        format.html { render :edit }
        format.json { render json: @user_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_news/1
  # DELETE /user_news/1.json
  def destroy
    @user_news.destroy
    respond_to do |format|
      format.html { redirect_to user_news_index_url, notice: 'Пользовательская новость была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_news

      @business_card = params[:business_card]

      @user_news = UserNews.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_news_params
      params.require(:user_news).permit(:title, :content, :delta, :user_id)
    end
end

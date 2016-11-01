class Admin::CategoryValuesController < Admin::ApplicationController

  before_action :set_category_value, only: [:show, :edit, :update, :destroy]

  before_action :check_shoes, only: [:destroy]  

  # GET /category_values
  # GET /category_values.json
  def index
    @category_values = CategoryValue.all
  end

  # GET /category_values/1
  # GET /category_values/1.json
  def show
  end

  # GET /category_values/new
  def new
    @category_value = CategoryValue.new
    # @image = @category_value.build_image
  end

  # GET /category_values/1/edit
  def edit
  end

  # POST /category_values
  # POST /category_values.json
  def create
    @category_value = CategoryValue.new(category_value_params)

    respond_to do |format|
      if @category_value.save
        # if params[:image]
        #   # params[:image]['file'].each do |a|
        #     @image = @category_value.image.create!(:file => params[:image]['file'], :imageable_id => @category_value.id, :imageable_type => @category_value.class.name)
        #   # end
        # end        
        format.html { redirect_to [:admin, @category_value], notice: 'Компонент: Обувь был успешно создан.' }
        format.json { render :show, status: :created, location: @category_value }
      else
        format.html { render :new }
        format.json { render json: @category_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_values/1
  # PATCH/PUT /category_values/1.json
  def update
    respond_to do |format|
      if @category_value.update(category_value_params)
        # if params[:image]
        #   # params[:image]['file'].each do |a|
        #     @image_attachment = @category_value.image.build(:file => params[:image]['file'], :imageable_id => @category_value.id, :imageable_type => @category_value.class.name)
        #     @category_value.image = @image_attachment
        #     @category_value.save!
        #   # end
        # end        
        format.html { redirect_to [:admin, @category_value], notice: 'Компонент: Обувь был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @category_value }
      else
        format.html { render :edit }
        format.json { render json: @category_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_values/1
  # DELETE /category_values/1.json
  def destroy
    @category_value.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_values_url, notice: 'Компонент: Обувь был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_value
      @category_value = CategoryValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_value_params
# http://stackoverflow.com/questions/15919761/rails-4-nested-attributes-unpermitted-parameters      
      params.require(:category_value).permit(:title, :category_type_id, :public, image_attributes: ["file", "@original_filename", "@content_type", "@headers"])
      # params.require(:category_value).permit!
    end

  def category_type id
    CategoryType.find(id).title
  end

  def check_shoes

    # key = category_type @category_value.category_type_id
    key = @category_value.category_type_id    

    value = @category_value.id

    shoes_selection = Shoe.where("categories ->> '?' = '?'", key, value)
    # shoes_selection = Shoe.where("categories ->> ? = '?'", key, value)

    if shoes_selection.size > 0
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_category_values_url, notice: "Компонент: Обувь \"#{@category_value.title}\" не был удалён, потому что обувь #{shoes_selection.collect {|shoe| shoe.title }} содержит его в своём атрибуте категорий." }
        format.json { head :no_content }
      end
    end
  end

end

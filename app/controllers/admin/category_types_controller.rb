class Admin::CategoryTypesController < Admin::ApplicationController
  before_action :set_category_type, only: [:show, :edit, :update, :destroy]

  before_action :check_shoes, only: [:update, :destroy]

  before_action :check_category_values, only: [:destroy]

  # GET /category_types
  # GET /category_types.json
  def index
    @category_types = CategoryType.all
  end

  # GET /category_types/1
  # GET /category_types/1.json
  def show
  end

  # GET /category_types/new
  def new
    @category_type = CategoryType.new
  end

  # GET /category_types/1/edit
  def edit
  end

  # POST /category_types
  # POST /category_types.json
  def create
    @category_type = CategoryType.new(category_type_params)

    respond_to do |format|
      if @category_type.save
      # if @category_type.save && set_category
      # if set_category && @category_type.save
      # if set_category
        format.html { redirect_to [:admin, @category_type], notice: 'Подраздел был успешно создан.' }
        format.json { render :show, status: :created, location: @category_type }
      else
        format.html { render :new }
        format.json { render json: @category_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_types/1
  # PATCH/PUT /category_types/1.json
  def update
    respond_to do |format|
      
      if @category_type.update(category_type_params)
      # if set_category_value && @category_type.update(category_type_params)
        format.html { redirect_to [:admin, @category_type], notice: 'Подраздел был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @category_type }
      else
        format.html { render :edit }
        format.json { render json: @category_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_types/1
  # DELETE /category_types/1.json
  def destroy
    @category_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_types_url, notice: 'Подраздел был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_type
      @category_type = CategoryType.find(params[:id])      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_type_params
      # params.require(:category_type).permit(:title)
      params.require(:category_type).permit(:title, category_value_attributes: [:id, :title])
    end

    # def set_category_value

    #   value_id = category_type_params[:category_value_attributes][:id]

    #   @category_value = CategoryValue.find(value_id)

    #   @category_type.category_value = @category_value

    #   @category_type.save      
    # end

    # def set_category

    #   @category = Category.new Наименование: category_type_params[:title]

    #   @category.save
    #   # @category_type.create_category Наименование: category_type_params[:title]

    #   # @category.category_type = @category_type

    #   # @category_type.save
      
    # end

  def check_shoes

    key = @category_type.id

    aname = 'updated' if action_name == 'update'

    aname = 'destroyed' if action_name == 'destroy'

# http://stackoverflow.com/questions/32029369/ruby-rails-json-match-results-if-key-exists
    shoes_selection = Shoe.where("(categories->'?') is not null", key)
    # shoes_selection = Shoe.where("(categories->?) is not null", key)    

    if shoes_selection.size > 0
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_category_types_url, notice: "Подраздел \"#{@category_type.title}\" не был #{aname}, потому что обувь #{shoes_selection.collect {|shoe| shoe.title }} содержит его в своём атрибуте категорий." }
        format.json { head :no_content }
      end
    end
  end

  def check_category_values
    if @category_type.category_values.any?
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_category_types_url, notice: "Подраздел \"#{@category_type.title}\" не был удалён, потому что Компоненты: Обувь #{@category_type.category_values.collect {|component| component.title }} содержат его в своих атрибутах." }
        format.json { head :no_content }
      end
    end
  end

    
end
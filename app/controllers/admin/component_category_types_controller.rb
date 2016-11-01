class Admin::ComponentCategoryTypesController < Admin::ApplicationController
  before_action :set_component_category_type, only: [:show, :edit, :update, :destroy]

  before_action :check_for_components, only: [:destroy]

  before_action :check_for_component_category_values, only: [:destroy]

  after_action :set_sizerange, only: [:create, :update]


  # GET /component_category_types
  # GET /component_category_types.json
  def index
    @component_category_types = ComponentCategoryType.order(:number);
  end

  # GET /component_category_types/1
  # GET /component_category_types/1.json
  def show
  end

  # GET /component_category_types/new
  def new
    @component_category_type = ComponentCategoryType.new
  end

  # GET /component_category_types/1/edit
  def edit
  end

  # POST /component_category_types
  # POST /component_category_types.json
  def create
    @component_category_type = ComponentCategoryType.new(component_category_type_params)

    respond_to do |format|
      if @component_category_type.save
        format.html { redirect_to [:admin, @component_category_type], notice: 'Подраздел: Подошва был успешно создан.' }
        format.json { render :show, status: :created, location: @component_category_type }
      else
        format.html { render :new }
        format.json { render json: @component_category_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /component_category_types/1
  # PATCH/PUT /component_category_types/1.json
  def update
    respond_to do |format|
      if @component_category_type.update(component_category_type_params)
        format.html { redirect_to [:admin, @component_category_type], notice: 'Подраздел: Подошва был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @component_category_type }
      else
        format.html { render :edit }
        format.json { render json: @component_category_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /component_category_types/1
  # DELETE /component_category_types/1.json
  def destroy
    @component_category_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_component_category_types_url, notice: 'Подраздел: Подошва был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_category_type
      @component_category_type = ComponentCategoryType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_category_type_params
      params.require(:component_category_type).permit(:title, :component_type_id, :has_sizerange, :sizerange, :number, :public, {:component_category_value_ids => []})        
    end

  def check_for_components
    key = @component_category_type.id

# http://stackoverflow.com/questions/32029369/ruby-rails-json-match-results-if-key-exists
    components_selection = Component.where("(categories->'?') is not null", key)

    if components_selection.size > 0
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_component_category_types_url, notice: "Подраздел: Подошва \"#{@component_category_type.title}\" was not destroyed, because components #{components_selection.collect {|component| component.title }} contain it in the category attribute." }
        format.json { head :no_content }
      end
    end
  end


  def check_for_component_category_values
    if @component_category_type.component_category_values.any?
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_component_category_types_url, notice: "Подраздел: Подошва \"#{@component_category_type.title}\" was not destroyed, because Компоненты: Подошва #{@component_category_type.component_category_values.collect {|component| component.title }} contains it in its attributes." }
        format.json { head :no_content }
      end
    end
  end

  def set_sizerange

    @component_category_type.sizerange = Range.new params[:lower_sizerange_bound].to_i, 
    params[:upper_sizerange_bound].to_i 

    @component_category_type.save

  end  

end

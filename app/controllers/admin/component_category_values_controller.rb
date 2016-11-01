class Admin::ComponentCategoryValuesController < Admin::ApplicationController
  before_action :set_component_category_value, only: [:show, :edit, :update, :destroy]

  before_action :check_components, only: [:destroy]

  # before_action :get_component_types, only: [:new] 

  # GET /component_category_values
  # GET /component_category_values.json
  def index
    @component_category_values = ComponentCategoryValue.all
  end

  # GET /component_category_values/1
  # GET /component_category_values/1.json
  def show
  end

  # GET /component_category_values/new
  def new
    @component_category_value = ComponentCategoryValue.new
  end

  # GET /component_category_values/1/edit
  def edit
  end

  # POST /component_category_values
  # POST /component_category_values.json
  def create
    @component_category_value = ComponentCategoryValue.new(component_category_value_params)

    respond_to do |format|
      if @component_category_value.save
        format.html { redirect_to [:admin, @component_category_value], notice: 'Компонент: Подошва был успешно создан.' }
        format.json { render :show, status: :created, location: @component_category_value }
      else
        format.html { render :new }
        format.json { render json: @component_category_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /component_category_values/1
  # PATCH/PUT /component_category_values/1.json
  def update
    respond_to do |format|
      if @component_category_value.update(component_category_value_params)
        format.html { redirect_to [:admin, @component_category_value], notice: 'Компонент: Подошва был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @component_category_value }
      else
        format.html { render :edit }
        format.json { render json: @component_category_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /component_category_values/1
  # DELETE /component_category_values/1.json
  def destroy
    @component_category_value.destroy
    respond_to do |format|
      format.html { redirect_to admin_component_category_values_url, notice: 'Компонент: Подошва был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_category_value
      @component_category_value = ComponentCategoryValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_category_value_params
      params.require(:component_category_value).permit(:title, :component_category_type_id)
    end

def check_components

    key = @component_category_value.component_category_type_id

    value = @component_category_value.id

    components_selection = Component.where("categories ->> '?' = '?'", key, value)

    if components_selection.size > 0
      respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
        format.html { redirect_to admin_component_category_values_url, notice: "Компонент: Подошва \"#{@component_category_value.title}\" was not destroyed, because components #{components_selection.collect {|component| component.title }} contain it in the category attribute." }
        format.json { head :no_content }
      end
    end
  end

end

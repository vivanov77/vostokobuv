class Admin::ComponentTypesController < Admin::ApplicationController
  before_action :set_component_type, only: [:show, :edit, :update, :destroy]

  before_action :check_for_component_category_types, only: [:destroy]
  
  before_action :check_for_component_subtypes, only: [:destroy]

  before_action :check_for_components, only: [:destroy]  

  # GET /component_types
  # GET /component_types.json
  def index
    @component_types = ComponentType.order(:number);
  end

  # GET /component_types/1
  # GET /component_types/1.json
  def show
  end

  # GET /component_types/new
  def new
    @component_type = ComponentType.new
  end

  # GET /component_types/1/edit
  def edit
  end

  # POST /component_types
  # POST /component_types.json
  def create
    @component_type = ComponentType.new(component_type_params)

    respond_to do |format|
      if @component_type.save
        format.html { redirect_to [:admin, @component_type], notice: 'Раздел был успешно создан.' }
        format.json { render :show, status: :created, location: @component_type }
      else
        format.html { render :new }
        format.json { render json: @component_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /component_types/1
  # PATCH/PUT /component_types/1.json
  def update
    respond_to do |format|
      if @component_type.update(component_type_params)
        format.html { redirect_to [:admin, @component_type], notice: 'Раздел был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @component_type }
      else
        format.html { render :edit }
        format.json { render json: @component_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /component_types/1
  # DELETE /component_types/1.json
  def destroy
    @component_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_component_types_url, notice: 'Раздел был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_type
      @component_type = ComponentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_type_params
      params.require(:component_type).permit(:title, :aactive, :atitle, :acontent, :number, :has_sizerange, image_attributes: ["file", "@original_filename", "@content_type", "@headers"])
    end

    def check_for_component_category_types
      if @component_type.component_category_types.any?
        respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
          format.html { redirect_to admin_component_types_url, notice: "Раздел \"#{@component_type.title}\" не был удалён, потому что Подразделы: Подошва #{@component_type.component_category_types.collect {|component| component.title }} содержат его в своих атрибутах." }
          format.json { head :no_content }
        end
      end
    end

    def check_for_component_subtypes
      if @component_type.component_subtypes.any?
        respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
          format.html { redirect_to admin_component_types_url, notice: "Раздел \"#{@component_type.title}\" не был удалён, потому что подразделы #{@component_type.component_subtypes.collect {|component| component.title }} содержат его в своих атрибутах." }
          format.json { head :no_content }
        end
      end
    end

    def check_for_components
      if @component_type.components.any?
        respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
          format.html { redirect_to admin_component_types_url, notice: "Раздел \"#{@component_type.title}\" не был удалён, потому что подразделы #{@component_type.components.collect {|component| component.title }} содержат его в своих атрибутах." }
          format.json { head :no_content }
        end
      end
    end

end

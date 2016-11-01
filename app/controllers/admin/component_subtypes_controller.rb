class Admin::ComponentSubtypesController < Admin::ApplicationController
  before_action :set_component_subtype, only: [:show, :edit, :update, :destroy]

  before_action :check_for_components, only: [:destroy]  

  # GET /component_subtypes
  # GET /component_subtypes.json
  def index
    @component_subtypes = ComponentSubtype.all
  end

  # GET /component_subtypes/1
  # GET /component_subtypes/1.json
  def show
  end

  # GET /component_subtypes/new
  def new
    @component_subtype = ComponentSubtype.new
  end

  # GET /component_subtypes/1/edit
  def edit
  end

  # POST /component_subtypes
  # POST /component_subtypes.json
  def create
    @component_subtype = ComponentSubtype.new(component_subtype_params)

    respond_to do |format|
      if @component_subtype.save
        format.html { redirect_to [:admin, @component_subtype], notice: 'Подраздел был успешно создан.' }
        format.json { render :show, status: :created, location: @component_subtype }
      else
        format.html { render :new }
        format.json { render json: @component_subtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /component_subtypes/1
  # PATCH/PUT /component_subtypes/1.json
  def update
    respond_to do |format|
      if @component_subtype.update(component_subtype_params)
        format.html { redirect_to [:admin, @component_subtype], notice: 'Подраздел был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @component_subtype }
      else
        format.html { render :edit }
        format.json { render json: @component_subtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /component_subtypes/1
  # DELETE /component_subtypes/1.json
  def destroy
    @component_subtype.destroy
    respond_to do |format|
      format.html { redirect_to admin_component_subtypes_url, notice: 'Подраздел был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_subtype
      @component_subtype = ComponentSubtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_subtype_params
      params.require(:component_subtype).permit(:title, :component_type_id)         
    end

    def check_for_components
      if @component_subtype.components.any?
        respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
          format.html { redirect_to admin_component_subtypes_url, notice: "Подраздел \"#{@component_subtype.title}\" не был удалён, потому что товары #{@component_subtype.components.collect {|component| component.title }} содержат их в своих атрибутах." }
          format.json { head :no_content }
        end
      end
    end

        
end

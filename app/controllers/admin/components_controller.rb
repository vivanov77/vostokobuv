class Admin::ComponentsController < Admin::ApplicationController
  before_action :set_component, only: [:show, :edit, :update, :destroy]

  after_action :set_sizerange, only: [:create, :update]  

  # GET /components
  # GET /components.json
  def index
    @components = Component.order(:title)
  end

  # GET /components/1
  # GET /components/1.json
  def show
  end

  # GET /components/new
  def new
    @component = Component.new
  end

  # GET /components/1/edit
  def edit
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)

    respond_to do |format|
      if @component.save
      
        format.html { redirect_to [:admin, @component], notice: 'Товар был успешно создан.' }
        format.json { render :show, status: :created, location: @component }
      else
        format.html { render :new }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    respond_to do |format|
      if @component.update(component_params)
        if component_params[:main_image]
          format.html { redirect_to edit_admin_component_path(@component), notice: 'Было изменено главное изображение.' }
        else       
          format.html { redirect_to [:admin, @component], notice: 'Товар был успешно обновлён.' }
          format.json { render :show, status: :ok, location: @component }
        end
      else
        format.html { render :edit }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component.destroy
    respond_to do |format|
      format.html { redirect_to admin_components_url, notice: 'Товар был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      # params.require(:component).permit(:title)
      # params.require(:component).permit!

      # if params[:component][:categories].blank?

      #   params.require(:component).permit!

      # else

      #   params.require(:component).permit!.merge({
      #   categories: (params[:component][:categories]).delete_if { |k, v| v.empty? }
      # })   

      # end

      if params[:component][:categories]

# http://stackoverflow.com/questions/24939971/how-to-remove-empty-parameters-from-params-hash
        # new_params[:categories].reject!{|_, v| v.blank?} # remove empty params (which are hash values)

# http://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-transform_values-21
# http://stackoverflow.com/questions/5878697/how-do-i-remove-blank-elements-from-an-array

# p "params[:categories] = " + params[:categories].inspect

        params[:component][:categories].transform_values! { |value| value.reject(&:empty?) } # remove nested array empty elements

        params[:component][:categories].reject!{|k, v| v.blank?} # remove empty array (no filter value was set)

      end

      # if new_params[:component_subtype_id]

      #   new_params = new_params.merge(
      #     new_params.delete_if { |k, v| v.empty? }
      #     )

      # end

      # p "params = " + params.inspect

      params.require(:component).permit!
      # params.permit!

    end

  def set_sizerange

    @component.sizerange = Range.new params[:lower_sizerange_bound].to_i, 
    params[:upper_sizerange_bound].to_i 

    @component.save

  end
      
end
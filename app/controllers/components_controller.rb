class ComponentsController < ApplicationController
  # before_action :set_component, only: [:show, :edit, :update, :destroy]
  before_action :set_component, only: [:show]

  before_action :set_components, only: [:show, :index]

  add_breadcrumb "Комплектующие для обуви", :store_components_path

  # GET /components
  # GET /components.json
  def index    

    @components = Component

    @filters    

    @component_type

    @component_subtype_id

    if component_params[:component_type_id]

      @component_type = ComponentType.find params[:component_type_id]

      @components = @components.includes(:component_types).where( :component_types => {:id => params[:component_type_id]}).order(:title)

      if @component_type.component_category_types.size > 0

        @filters = ComponentCategoryType.where(public: true)

        @filters = @filters.where(component_type_id: params[:component_type_id])

        @filters = @filters.order(:number) 

      elsif @component_type.component_subtypes.size > 0

        @filters = @component_type

        # @filters = @filters.where(component_type_id: params[:component_type_id])        

      end

      add_breadcrumb "#{@component_type.title}", components_path(component_type_id: component_params[:component_type_id])

    else

      add_breadcrumb "Товары", :components_path

    end

    if component_params[:categories]

      # @shoes = shoes.where("categories ->> '12' = '23' AND categories ->> '13' = '19'")

      # Component.where("categories #>> '{\"3\",0}' = '1' OR categories #>> '{\"3\",1}' = '1' ")
 
      categories_st = "("

      component_params[:categories].each_pair do |key, value|

        filter_size = ComponentCategoryValue.where(component_category_type_id: key).size

# http://www.tutorialspoint.com/ruby/ruby_loops.htm
        for i in 0...value.size

          for j in 0...filter_size

            categories_st << "categories #>> '{\"#{key}\",#{j}}' = '#{value[i]}'#{(j==filter_size-1 ? ") AND (" : " OR ")}"

          end

        end

      end

      # categories_st = categories_st.slice(0, categories_st.length - 5)
      categories_st = categories_st.slice(0, categories_st.length - 7)

      categories_st << ")" if categories_st

      @components = @components.where(categories_st)

    end

    if component_params[:component_subtype_id]

      @component_subtype_id = component_params["component_subtype_id"]

# http://stackoverflow.com/questions/4687004/rails-habtm-relationship-how-can-i-find-a-record-based-on-an-attribute-of-t
      @components = @components.includes(:component_subtypes).where(component_subtypes: {id: @component_subtype_id})

    end

    if component_params[:size]

      @size = component_params[:size]

      categories_st = ""

      @size.each do |el|

        # categories_st << "sizerange @> #{el} AND "
        categories_st << "sizerange @> #{el} OR "      

      end

      # categories_st = categories_st.slice(0, categories_st.length - 5)
      categories_st = categories_st.slice(0, categories_st.length - 4)      

      @components = @components.where(categories_st)

    end

    @components = @components.order(:title)

    @categories = component_params[:categories].to_h

    respond_to do |format|
      format.html {}
      format.js {}
    end

  end

  # GET /components/1
  # GET /components/1.json
  def show

    component_type = @component.component_types.first

    add_breadcrumb "#{component_type ? component_type.title : 'Товары'}", component_type ? components_path(component_type_id: component_type.id) : components_path

    # http://stackoverflow.com/questions/35614878/breadcrumbs-on-rails-list-show-as-child-of-index
    add_breadcrumb "#{@component.title}", component_path(@component.id)    

    @components = Component.where.not(id: params[:id]).includes(:component_types).where( :component_types => {:id => @component.component_types.first.id}).order(:title)
  end

  # # GET /components/new
  # def new
  #   @component = Component.new
  # end

  # # GET /components/1/edit
  # def edit
  # end

  # # POST /components
  # # POST /components.json
  # def create
  #   @component = Component.new(component_params)

  #   respond_to do |format|
  #     if @component.save
  #       format.html { redirect_to [:admin, @component], notice: 'Component был успешно создан.' }
  #       format.json { render :show, status: :created, location: @component }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @component.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /components/1
  # # PATCH/PUT /components/1.json
  # def update
  #   respond_to do |format|
  #     if @component.update(component_params)
  #       format.html { redirect_to [:admin, @component], notice: 'Component был успешно обновлён.' }
  #       format.json { render :show, status: :ok, location: @component }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @component.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /components/1
  # # DELETE /components/1.json
  # def destroy
  #   @component.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_components_url, notice: 'Component был успешно удалён.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.where(id: params[:id]).includes(:component_subtypes).first
    end

    def set_components
      
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

      # new_params = params

      # p "new_params = " + new_params.inspect
      # p "params = " + params.inspect
      # p "new_params[:categories] = " + new_params[:categories].inspect

      if params[:categories]

# http://stackoverflow.com/questions/24939971/how-to-remove-empty-parameters-from-params-hash
        # new_params[:categories].reject!{|_, v| v.blank?} # remove empty params (which are hash values)

# http://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-transform_values-21
# http://stackoverflow.com/questions/5878697/how-do-i-remove-blank-elements-from-an-array

        params[:categories].transform_values! { |value| value.reject(&:empty?) } # remove nested array empty elements

        params[:categories].reject!{|k, v| v.blank?} # remove empty array (no filter value was set)

      end

      # if new_params[:component_subtype_id]

      #   new_params = new_params.merge(
      #     new_params.delete_if { |k, v| v.empty? }
      #     )

      # end

      # p "params = " + params.inspect

      params.permit!

    end
end
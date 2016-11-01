class StoreComponentsController < ApplicationController
  
  # before_action :set_category_value, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Комплектующие для обуви", :store_components_path

  def index
    # @category_types = CategoryType.all
    # @category_values = CategoryValue.where(public: true).order(:title)
    # @component_types = ComponentType.order(:title)
    @component_types = ComponentType.order(:number)    

    @description = "Виды разделов"

    @components = Component.all
  end	
end

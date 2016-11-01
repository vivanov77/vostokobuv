class StoreShoesController < ApplicationController
  
  # before_action :set_category_value, only: [:show, :edit, :update, :destroy]

  def index
    # @category_types = CategoryType.all
    # @category_values = CategoryValue.where(public: true).order(:title)

    @description = "Виды обуви"

    @shoes = Shoe.order(:created_at)

    @filters = CategoryType.order(:title)

    @articles = Article.order(:created_at)

    @wolf = params[:wolf]
  end	
end

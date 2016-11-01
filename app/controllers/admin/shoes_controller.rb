class Admin::ShoesController < Admin::ApplicationController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]

  # GET /shoes
  # GET /shoes.json
  def index
    @shoes = Shoe.all
  end

  # GET /shoes/1
  # GET /shoes/1.json
  def show 
  end

  # GET /shoes/new
  def new
    @shoe = Shoe.new
  end

  # GET /shoes/1/edit
  def edit
  end

  # POST /shoes
  # POST /shoes.json
  def create
    @shoe = Shoe.new(shoe_params)
    
    respond_to do |format|
      if @shoe.save
        format.html { redirect_to [:admin, @shoe], notice: 'Обувь была успешно создана.' }
        format.json { render :show, status: :created, location: @shoe }
      else
        format.html { render :new }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoes/1
  # PATCH/PUT /shoes/1.json
  def update
    respond_to do |format|
      if @shoe.update(shoe_params)
        format.html { redirect_to [:admin, @shoe], notice: 'Обувь была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @shoe }
      else
        format.html { render :edit }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoes/1
  # DELETE /shoes/1.json
  def destroy
    @shoe.destroy
    respond_to do |format|
      format.html { redirect_to admin_shoes_url, notice: 'Обувь была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe
      @shoe = Shoe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shoe_params
      # params.require(:shoe).permit(:title, :producer_id, :category_type_ids).permit!
      # params.require(:shoe).permit(:title, :producer_id, {:category_ids => []})
      # params.require(:shoe).permit!.merge({
      #   categories: (params[:shoe][:categories]).to_json
      # })
      # params.require(:shoe).permit!

      params.require(:shoe).permit!.merge({
        categories: (params[:shoe][:categories]).delete_if { |k, v| v.empty? }
      })

      # http://stackoverflow.com/questions/3183786/how-to-convert-a-ruby-hash-object-to-json
      # http://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-merge
      # http://stackoverflow.com/questions/3450641/removing-all-empty-elements-from-a-hash-yaml      
    end
end
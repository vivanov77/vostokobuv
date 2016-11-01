class ShoesController < ApplicationController
  # before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action :set_shoe, only: [:show]

  # GET /shoes
  # GET /shoes.json
  def index

    @shoes = Shoe

    @filters = CategoryType

    if shoe_params[:categories]

      # @shoes = shoes.where("categories ->> '12' = '23' AND categories ->> '13' = '19'")
      
      @categories_st = ""

      shoe_params[:categories].each_pair {|key, value| @categories_st << "categories ->> '#{key}' = '#{value}' AND " }

      @categories_st = @categories_st.slice(0, @categories_st.length - 5)

      @shoes = @shoes.where(@categories_st)

    end

    if shoe_params[:user_id]

      @shoes = @shoes.where(user_id: params[:user_id])

    end    
   
    @shoes = @shoes.order(:title)

    @filters = @filters.order(:title)   

    @categories = params[:categories]

    @producer_id = params[:user_id]

    @producers = User.where(producer: true).order(:organization)

    # @category_values = CategoryValue.where(public: true).order(:title)

  end

  # GET /shoes/1
  # GET /shoes/1.json
  def show
    @opinions = Opinion.where(user_id: @shoe.user_id).order(:created_at)
  end

#   # GET /shoes/new
#   def new
#     @shoe = Shoe.new
#   end

#   # GET /shoes/1/edit
#   def edit
#   end

#   # POST /shoes
#   # POST /shoes.json
#   def create
#     @shoe = Shoe.new(shoe_params)
# #http://stackoverflow.com/questions/3450641/removing-all-empty-elements-from-a-hash-yaml
#     # @shoe.categories.delete_if { |k, v| v.empty? }

#     respond_to do |format|
#       if @shoe.save
#         format.html { redirect_to [:admin, @shoe], notice: 'Shoe был успешно создан.' }
#         format.json { render :show, status: :created, location: @shoe }
#       else
#         format.html { render :new }
#         format.json { render json: @shoe.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /shoes/1
#   # PATCH/PUT /shoes/1.json
#   def update
#     respond_to do |format|
#       # if @shoe.update(shoe_params) && set_shoe_categories
#       if @shoe.update(shoe_params)

#         # @shoe.categories.delete_if { |k, v| v.empty? }
#         # @shoe.save!

#         format.html { redirect_to [:admin, @shoe], notice: 'Shoe был успешно обновлён.' }
#         format.json { render :show, status: :ok, location: @shoe }
#       else
#         format.html { render :edit }
#         format.json { render json: @shoe.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /shoes/1
#   # DELETE /shoes/1.json
#   def destroy
#     @shoe.destroy
#     respond_to do |format|
#       format.html { redirect_to admin_shoes_url, notice: 'Shoe был успешно удалён.' }
#       format.json { head :no_content }
#     end
#   end

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
      # params.require(:shoe).permit!.except(:utf8, :commit)
      # params.permit!.except(:utf8, :commit)
      # params.permit!.merge({
      #   categories: (params[:shoe][:categories]).delete_if { |k, v| v.empty? }
      # })

      # if params[:categories]

      #   params.permit!.merge({
      #   categories: (params[:categories]).delete_if { |k, v| v.empty? }
      # })

      # else

      #   params.permit!

      # end

      new_params = params

      if new_params[:categories]

        new_params = new_params.merge({
          categories: (new_params[:categories]).delete_if { |k, v| v.empty? }
          })

      end

      if new_params[:user_id]

        new_params = new_params.merge(
          new_params.delete_if { |k, v| v.empty? }
          )

      end

      new_params          

      # params.require(:shoe).permit!.merge({
      #   categories: (params[:shoe][:categories]).delete_if { |k, v| v.empty? }
      # })

      # http://stackoverflow.com/questions/3183786/how-to-convert-a-ruby-hash-object-to-json
      # http://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-merge
      # http://stackoverflow.com/questions/3450641/removing-all-empty-elements-from-a-hash-yaml      
    end
end


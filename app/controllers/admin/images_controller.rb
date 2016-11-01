class Admin::ImagesController < Admin::ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  before_action :check_imageable, only: [:destroy]

  after_action :check_thumbs, only: [:update]

  before_action :check_main_image, only: [:destroy]  

  # GET /images
  # GET /images.json
  def index
    @images = Image.order(:imageable_type, :imageable_id)
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to [:admin, @image], notice: 'Изображение было успешно создано.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to [:admin, @image.imageable], notice: 'Изображение было успешно обновлено.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      notice = 'Изображение было успешно удалено.'
      format.html { params[:redirect_back].blank? ? (redirect_to admin_images_url, notice: notice) : redirect_back(fallback_location: admin_images_url, notice: notice) }      
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:imageable_id, :imageable_type, :image)
    end

    def check_imageable

      if @image.imageable && !params[:redirect_back]
        notice = "Изображение \"#{@image.file.to_s}\" не было удалено, потому что родитель \"#{@image.imageable.title}\" содержит его."

        respond_to do |format|
# http://stackoverflow.com/questions/5254732/difference-between-map-and-collect-in-ruby        
          format.html { params[:redirect_back].blank? ? (redirect_to admin_images_url, notice: notice) : redirect_back(fallback_location: admin_images_url, notice: notice) }
          format.json { head :no_content }
        end
      end
    end

    def check_main_image

      parent = @image.imageable

      if parent.class.name.to_s.downcase == "component"

        if parent.images[parent.main_image].id == @image.id

          parent.main_image = 0;

          parent.save

        end

      end

    end

    def check_thumbs
# http://stackoverflow.com/questions/10544598/carrierwave-thumb-issue
      @image.file.recreate_versions!

    end

end

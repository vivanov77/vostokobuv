class TinymceAssetsController < ApplicationController
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed

    fname = params[:file].original_filename

    ri = fname.rindex(".")    

    if ri && (['gif', 'jpg', 'png', 'jpeg', 'svg'].include? fname[fname.rindex(".")+1..-1])

      # image = Image.create file: params[:file], :imageable_type => "Article"
      image = Image.create file: params[:file]    

      render json: {
        image: {
          url: image.file.url
        }
      }, content_type: "text/html"

    else

      render json: {
        error: {
          message: "Недопустимый тип файла. <br>Можно загружать только .jpg, .jpeg, .png, .gif, .svg"
        }
      }, content_type: "text/html"

    end

  end
end
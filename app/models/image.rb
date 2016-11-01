class Image < ApplicationRecord
	mount_uploader :file, ImageUploader

	belongs_to :imageable, polymorphic: true

# http://stackoverflow.com/questions/7527887/validate-image-size-in-carrierwave-uploader
	#validate :validate_minimum_image_size

	def validate_minimum_image_size

		r_img = Magick::Image::read(self.file.path)[0]

	    if r_img

		    width = r_img.columns
		    height = r_img.rows

		    if width != height
		    	self.errors.add "", "Инна, мы же решили, что загружаемые изображения должны быть квадратными. А у этого изображения ширина #{width} пикселей, а высота #{height} пикселей."
		    end
		   	r_img.destroy!
	    else
	    	self.errors.add "", "Не удалось открыть файл загружаемого изображения."
	    end
	end
end
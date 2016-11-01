
namespace :vo do

  desc 'Сгенерировать заново все миниатюры'
  task rethumb: :environment do
    regenerate_thumbnails
  end

  def regenerate_thumbnails

    # p :regenerate_thumbnails

    length = Image.all.size

    Image.all.each_with_index do |image, index|
# http://stackoverflow.com/questions/10544598/carrierwave-thumb-issue

      p "Processing #{index} of #{length}"

      image.file.recreate_versions!

    end
    
  end
end
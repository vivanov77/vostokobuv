module ApplicationHelper

  def category_type id
    CategoryType.find(id).title
  end

  def category_value id
    CategoryValue.find(id).title
  end

  def component_category_type id
    ComponentCategoryType.find(id).title
  end

  def component_category_value id
    ComponentCategoryValue.find(id).title
  end

  def root_page?
    # controller.class.to_s == "StoreShoesController"
# http://stackoverflow.com/questions/31817051/ruby-on-rails-if-current-page-is-homepage-dont-show-form    
    current_page?('/') || current_page?('/store_shoes')
  end

  def components_root_page?
    current_page?('/store_components')
  end

  def shoes_pages?
    controller.controller_name != 'components' &&
    controller.controller_name != 'orders'
  end  

  def components_pages?
# http://stackoverflow.com/questions/5186613/rails-current-page-versus-controller-controller-name    
    controller.controller_name == 'components'
  end

  def profile_pages?
    current_user && 
    (
      ((controller.controller_name == 'users' || controller.controller_name == 'registrations') && action_name == "edit") || 

      controller.controller_name == 'user_news'
    )

  end  

  def active_name controller, name
    controller.class.to_s.downcase.first(4) == name.first(4).downcase ? ' class=' + html_escape("") + 'active' + html_escape("") : ''
  end

  def active_name2 menu_value
# http://stackoverflow.com/questions/2165665/how-do-i-get-the-current-absolute-url-in-ruby-on-rails    
    request.original_fullpath == shoes_path(:categories => {menu_value.category_type_id => menu_value.id }) ? ' class=' + html_escape("") + 'active' + html_escape("") : ''
  end

  def active_name_url url
    request.original_fullpath == url ? ' class=' + html_escape("") + 'active' + html_escape("") : ''
  end

  def verify_google_recptcha(secret_key,response)

    return false if response.blank?

     uri = URI('https://www.google.com/recaptcha/api/siteverify')
     res = Net::HTTP.post_form(uri, 'secret' => secret_key, 'response' => response)   
     
     hash = JSON.parse(res.body)

     hash["success"] == true ? true : false
  end

  def param2hash param
    # http://stackoverflow.com/questions/1667630/how-do-i-convert-a-string-object-into-a-hash-object
    # arr["1"]
    JSON.parse param.gsub('=>', ':') 
  end

  def thumb_text
# http://stackoverflow.com/questions/11992540/nokogiri-text-node-contents   
    # content_array = Nokogiri::HTML(self.content).search('//text()').map(&:text).delete_if{|x| x !~ /\w/}
    content_array = Nokogiri::HTML(self.content).search('//text()').map(&:text)    
# http://stackoverflow.com/questions/3500814/ruby-array-to-string-conversion
    title = content_array.join(" ")

    limit = 190

    trail = (limit - title.to_s.length) 

    title.to_s.length > limit ? title.to_s.slice(0,limit-3) + "..." : title.to_s    
    
  end

  def tinymce_form_images_urls
    Nokogiri::HTML(self.content).xpath('//img').collect { |x|  x['src'] }
  end  

  def bind_tinymce_images_to_parent parent, parent_content_name

    # http://stackoverflow.com/questions/1556028/how-do-i-do-a-regex-search-in-nokogiri-for-text-that-matches-a-certain-beginning
    # http://stackoverflow.com/questions/30221714/finding-webelement-by-xpath-using-regex
    # http://stackoverflow.com/questions/27217663/where-does-carrierwave-stores-uploads

    images_nil = Image.where(imageable_id: nil)

    if images_nil

      src_path = "/" + Image.first.file.store_dir.slice(0,Image.first.file.store_dir.rindex("/")+1)

      html = Nokogiri::HTML(parent[parent_content_name])

      image_ids = html.xpath("//img[starts-with(@src, \"#{src_path}\")]").collect { |x|  x['src'].gsub(src_path,"").split("/")[0].to_i }        

      image_ids.each do |image_id|

        image = Image.find image_id

        if image

          image.imageable_type = parent.class.name

          image.imageable_id = parent.id

          image.save!

        end
      end

    end
  end

  def ds(param_date, format="%d %B %Y")
    Russian::strftime(param_date, format).to_s
  end

  def heroku?
# http://stackoverflow.com/questions/9383450/how-can-i-detect-herokus-environment    
    Rails.env.production? && !ENV['DYNO'].blank?
  end  

  def secret_key key

    heroku? ? ENV[key] : Rails.application.secrets[key]

  end

  def submit_russian_text rus_model_name

    if action_name == "new"

      "Создать " + rus_model_name

    elsif action_name == "edit"

      "Сохранить " + rus_model_name      

    end

  end

  def set_layout
    if @business_card
      render :layout => 'business_card'
    else
      render :layout => 'application'
    end
  end

  def chi obj, thumb_size=false
  # <%= link_to(image_file_tag(@component), @component) %>

    if obj.respond_to? "images"

      if obj.images.size > 0

        image_index = obj.class.to_s.downcase == "component" ? obj.main_image : 0

        thumb_size ? obj.images[image_index].file.send("thumb" + thumb_size.to_s).url : obj.images[image_index].file_url

      else

        "no_image.png"

      end

    elsif obj.respond_to? "image"

      if obj.image

        thumb_size ? obj.image.file.send("thumb" + thumb_size.to_s).url : obj.image.file_url

      else

        "no_image.png"

      end      
      
    end

  end

  def remote_file_exists?(url)

     response = Net::HTTP.get_response(URI(url))

     response.code == "200" ? true : false

  end

  def image_stored_file_path image
# http://stackoverflow.com/questions/2733007/urldecode-in-ruby
    URI.unescape(image.file.to_s).to_s
  end

  def image_real_file_path image
    "public/" + image_stored_file_path(image)[1..-1].to_s
  end

  def get_image_url req, image
# http://stackoverflow.com/questions/21321687/rails-get-app-root-base-url
    req.base_url.to_s + image.file.to_s
  end

  def get_thumb_url req, image, thumb_size
# http://stackoverflow.com/questions/21321687/rails-get-app-root-base-url
    req.base_url.to_s + image.file.send("thumb" + thumb_size.to_s).url
  end

  def image_info image
# http://stackoverflow.com/questions/3614389/what-is-the-easiest-way-to-remove-the-first-character-from-a-string
    r_img = Magick::Image::read(image_real_file_path image)[0]

    if r_img
      res = {}
# http://stackoverflow.com/questions/16266933/rmagick-how-do-i-find-out-the-pixel-dimension-of-an-image      
      res["width"] = r_img.columns
      res["height"] = r_img.rows
# http://rmagick.github.io/imageattrs.html#filesize      
      res["filesize"] = r_img.filesize # filesize in bytes
      if r_img.filesize > 1024*1024
        res["filesize2"] = r_img.filesize / 1024*1024
        res["filesize_unit"] = "Mb"
      else
        res["filesize2"] = r_img.filesize / 1024
        res["filesize_unit"] = "Kb"        
      end
# http://stackoverflow.com/questions/958681/how-to-deal-with-memory-leaks-in-rmagick-in-ruby      
      r_img.destroy!
      res
    else
      nil
    end
  end

  def vert_menu_remote?

    controller.controller_name == 'components' && action_name == "index"

  end

  def repnil val, rep

    val ? val : rep

  end

  def no_vert_menu_page?

    controller.controller_name == 'search' ||
    controller.controller_name == 'sessions' || 
    controller.controller_name == 'confirmations' ||
    controller.controller_name == 'passwords' ||
    controller.controller_name == 'info' ||
    root_page? || 
    components_root_page? 

  end

end
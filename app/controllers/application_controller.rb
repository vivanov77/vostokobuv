class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception 

  before_action :set_menu_values

  def after_sign_in_path_for(resource)
    #current_user_path

    if current_user.first_name.blank? ||
      current_user.middle_name.blank? ||
      current_user.last_name.blank?

      edit_user_path(current_user)
    else
      root_path
    end

  end

  def after_sign_out_path_for(resource_or_scope)
    # request.referrer
    root_path
  end

  private  

  def set_menu_values

    @menu_category_values = CategoryValue.where(public: true).order(:title)
    @menu_component_types = ComponentType.order(:number) 

    @menu_shoes = []
    @menu_components = []
    @menu_profile = []

    @menu_shoes.push({title: "По производителям", href: users_path})

    # @menu_category_values.each do |menu_value|

    #   @menu_shoes.push({title: menu_value.title, href: shoes_path(:categories => {menu_value.category_type_id => menu_value.id })})

    # end

    @menu_component_types.each do |menu_type|

      @menu_components.push({title: menu_type.title, href: components_path(component_type_id: menu_type.id)})

    end

    if current_user

      @menu_profile.push({title: "Тип пользователя", href: edit_user_path(current_user)})

      @menu_profile.push({title: "Данные пользователя", href: edit_user_path(current_user, type: :data)})

      @menu_profile.push({title: "Сменить пароль", href: edit_user_registration_path})

      @menu_profile.push({title: "Управление новостями", href: edit_user_path(current_user, type: :user_news)})            

    end

  end
end
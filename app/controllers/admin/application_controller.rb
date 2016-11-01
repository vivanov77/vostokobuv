class Admin::ApplicationController < ApplicationController

  layout 'admin'

  before_action :authenticate_user!
  load_and_authorize_resource

  def ru_action name

	case name.to_s
	when "edit"
	  "редактирование"
	when "new"
	  "создание"
	when "destroy"
	  "удаление"	  
	else
	  "внесение измений"
	end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.blocked?
    sign_out
    redirect_to store_path, notice: "Your user was blocked."
  else
    redirect_to :back, notice:    
    #"You don't have the right to #{exception.action} #{exception.subject.class.to_s.downcase.pluralize}"
    # "You don't have the right to #{exception.action} #{exception.subject.class.to_s.downcase == 'class' ? exception.subject.to_s.pluralize : exception.subject.class.to_s}"
    "У Вас нет прав на #{ru_action exception.action}."
    #"You don't have the right to #{exception.action} #{exception.subject.class}"
  end
  end   

  # layout 'admin' if (controller.class.to_s.downcase.first(5) == "admin")  
 
end

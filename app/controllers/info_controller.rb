class InfoController < ApplicationController

  def about
  end

  def under_construction
  end

  def faq
  	@configurable = Configurable[:faq]
  end

  def delivery
  	@configurable = Configurable[:delivery]
  end  

end

class SearchController < ApplicationController
  def index
    @keyword = params[:keyword]

    @shoes = Shoe.search @keyword
    @components = Component.search @keyword
    # @events = Event.search query
    # @publications = Publication.search query
  end
end
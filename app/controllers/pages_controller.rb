class PagesController < ApplicationController

  def gallery
    render(:layout => "layouts/gallery")
  end

  def index
    render(:layout => "layouts/main")
  end

  private

end

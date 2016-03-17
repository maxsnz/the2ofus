class Api::PhotosController < Api::BaseController
  def show
    photo = Photo.find(params[:id]).full_json
    render_json(photo)
  end

  def index
    photos = Photo.visible.all
    render_json(photos)
  end
end

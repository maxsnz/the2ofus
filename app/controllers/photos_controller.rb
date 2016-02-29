class PhotosController < ApplicationController
  def show
    @photo = Photo.visible.find(params[:id])
    meta "og:image" => @photo.src
    render layout: "facebook"
  end
end

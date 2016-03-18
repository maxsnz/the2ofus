class PhotosController < ApplicationController
  def show
    @photo = Photo.visible.find(params[:id])
    meta("og:image" => @photo.src)
    if mobile_device?
      render template: "pages/gallery", layout: "gallery_mobile"
    else
      render template: "pages/gallery", layout: "gallery"
    end
  end
end
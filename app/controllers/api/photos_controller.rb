class Api::PhotosController < Api::BaseController
  def index
    @photos = Photo.feed

    render_json({
      photos: @photos.as_json(view_context: view_context, host: request.host)
    })
  end
end

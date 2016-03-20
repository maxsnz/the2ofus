class Api::PhotosController < Api::BaseController
  def show
    photo = Photo.find(params[:id]).full_json
    render_json(photo)
  end

  def index
    # photos = Photo.visible.all
    # render_json(photos)

    # order_field = params[:order] == "rating" ? "rating" : "id"
    order_field = "id"
    collection = scope.order("#{order_field} desc").paginate(page: params[:page], per_page: 10)

    render_json({
      total_pages: collection.total_pages,
      current_page: collection.current_page,
      photos: collection.as_json(host: request.host)
    })
  end

  def scope
    Photo.visible
  end

end

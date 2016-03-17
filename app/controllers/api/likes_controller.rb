class Api::LikesController < Api::BaseController
  before_filter :authenticate!, only: [:create, :index]
  # before_filter :authenticate!, only: :show

  def create
    photo = Photo.find(params[:photo_id])

    @like = Like.new(user: @current_user, photo: photo)
    if Like.all.where(:photo => photo, user: @current_user).length == 0
      if @like.save
        render_json({ ok: true })
        update_photo_rating(photo)
      else
        render_json({ ok: false, errors: @like.errors })
      end
    else
      render_json({ ok: false, errors: 'already liked' })
    end

  end

  def index
    @likes = Like.all.where(user: @current_user)
    render_json(@likes)
  end

  def update_photo_rating(photo)
    rating = Like.all.where(:photo => photo).length
    photo.rating = rating
    photo.save
  end

end
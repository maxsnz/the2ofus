class PhotoService
  include CallableClass

  attr_reader :photo

  def initialize(photo)
    @photo = photo
  end

  def call
    raise NotImplementedError
  end
end

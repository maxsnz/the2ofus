class Photo < ActiveRecord::Base
  extend Enumerize


  INSTAGRAM = 'in'
  FACEBOOK  = 'fb'
  VKONTAKTE = 'vk'
  SOURCES   = [INSTAGRAM, FACEBOOK, VKONTAKTE]

  AWAITING_MODERATION = 'awaiting_moderation'
  PUBLISHED           = 'published'
  REFUSED             = 'refused'
  WINNER              = 'winner'
  VISIBLE_STATES      = [ PUBLISHED, WINNER ]

  enumerize :source, in: SOURCES, predicates: true

  state_machine :initial => AWAITING_MODERATION do
    state PUBLISHED
    state REFUSED

    event :publish do
      transition [AWAITING_MODERATION, REFUSED] => PUBLISHED
    end

    event :refuse do
      transition [AWAITING_MODERATION, PUBLISHED] => REFUSED
    end

    event :make_a_winner do
      transition PUBLISHED => WINNER
    end

    event :move_back_to_published do
      transition WINNER => PUBLISHED
    end
  end

  # mount_uploader :image, PhotoUploader

  scope :awaiting_moderation, -> { with_state(AWAITING_MODERATION) }
  scope :visible,             -> { with_state(VISIBLE_STATES) }
  scope :winners,             -> { with_state(WINNER) }
  scope :refused,             -> { with_state(REFUSED) }

  scope :feed, -> { visible.where("posted_at<=?", Date.today).order("posted_at desc, id") }

  SOURCES.each do |source|
    scope source, -> { where(source: source) }
  end

  validates_presence_of :src, :uid, :username, :user_uid
  validates :source, presence: true, inclusion: { in: SOURCES }
  # validates_uniqueness_of :uid, scope: :source, on: :create


  validates_presence_of :posted_at, on: :update, if: :published?

  # def as_json(options = {})
  #   attributes.slice(*%w{id name userpic src rating body}).merge({
  #     id: id,
  #     posted_at: I18n.l(posted_at, format: :short),
  #     username: fullname.presence || username,
  #     userpic: userpic,
  #     # winner: winner?,
  #     thumb: thumb || options[:view_context].asset_path("thumb_deleted.jpg"),
  #     src: src || options[:view_context].asset_path("full_deleted.jpg"),
  #     url: url
  #   })
  # end

  def as_json(options = {})
    attributes.slice(*%w{id name src}).merge({
      id: id,
      username: fullname.presence || username,
      src: src || options[:view_context].asset_path("full_deleted.jpg")
    })
  end

  def full_json(options = {})
    attributes.slice(*%w{id name src rating body }).merge({
      id: id,
      username: fullname.presence || username,
      src: src || options[:view_context].asset_path("full_deleted.jpg")
    })
  end

  def winner_count
    self.class.winners.where(user_uid: user_uid).count
  end

  private

end

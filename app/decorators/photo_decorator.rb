# encoding: UTF-8
class PhotoDecorator < Draper::Decorator
  include CityConcern

  delegate :lat, :lon, :rating, :id, :username, :fullname, :name, :address, :uid

  def body
    h.simple_format(model.body)
  end

  def date
    return unless model.date?
    l model.date, format: :short
  end

  def source
    h.content_tag(:span, model.source_text, class: "status_tag")
  end

  def image
    h.link_to_unless_current(h.image_tag(model.image.thumb, :size => '100x100'), h.resource_path(model))
  end

  def userpic
    h.image_tag(model.userpic, size: '50x50')
  end

  def url
    h.link_to(model.url, model.url)
  end

  def state
    text = h.content_tag(:span, model.human_state_name, :class => h.classes('status_tag', 'ok' => model.published?, 'orange' => model.winner?))

    n = model.winner_count
    text << " "
    text << h.t("winner_count", count: n)

    model.state_events.each do |event|
      text << " "
      text << h.link_to(Photo.human_state_event_name(event), h.change_admin_photo_path(model, :event_method => event), :method => :put, :remote => !h.current_page?(h.resource_path(model)))
    end

    h.content_tag :div, text.html_safe, :id => h.dom_id(model, :state)
  end

  def created_at
    l model.created_at, format: :long
  end

  Like::SOURCES.each do |source|
    define_method source do
      n = model.likes_for(source)
      any_likes = n > 0 && model.likes.any? { |l| l.source == source }
      h.link_to_if(any_likes, n, h.csv_admin_photo_path(model, source: source))
    end
  end
end

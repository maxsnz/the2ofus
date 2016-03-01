ActiveAdmin.register Photo do
  actions :index, :show, :edit, :update

  filter :posted_at
  filter :source, as: :select, collection: proc { Photo.source.options }
  filter :uid
  filter :username

  batch_action :destroy, false

  batch_action :refuse do |selection|
    Photo.find(selection).each { |p| p.refuse }
    redirect_to collection_path
  end

  config.sort_order = "posted_at_desc"
  config.per_page = 50

  scope(:awaiting_moderation, :default => true) do |photos|
    photos.awaiting_moderation
  end

  scope :visible do |photos|
    photos.visible
  end

  scope :refused do |photos|
    photos.refused
  end

  index :download_links => false do
    # sources_hash = Like::SOURCES.inject({}) { |memo, source| memo.merge({ source.to_sym => false })}
    selectable_column
    {
      id: :id,
      posted_at: :posted_at,
      source: false,
      image: false,
      username: false,
      body: false,
      state: false,
      rating: :rating,
    }.each do |name, sortable|
      column name, sortable: sortable do |photo|
        photo.decorate.send(name)
      end
    end
    actions
  end

  form partial: "form"

  show do
    attributes_table do
      (%i{
        id
        uid
        posted_at
        source
        
        state
        username
        fullname
        image
        body
        userpic
        url
        created_at
        rating
       }).each do |name|
        row(name) do |photo|
          photo.decorate.send(name)
        end
      end
    end
  end

  member_action :change, :method => :put do
    resource.send(params[:event_method])
    redirect_to(resource_path) unless request.xhr?
  end

  member_action :csv, method: :get do
    send_data CreateCSV.call(resource, params[:source]), filename: "#{resource.id}_#{params[:source]}.csv", type: 'text/csv'
  end

  controller do
    include PermitConcern

    # def scoped_collection
    #   super.includes(:likes)
    # end
  end
end

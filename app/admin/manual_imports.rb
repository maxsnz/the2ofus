ActiveAdmin.register ManualImport do
  actions :new, :create
  config.filters = false

  form partial: "form"

  controller do
    include PermitConcern

    def index
      redirect_to action: :new
    end

    def create
      @manual_import = ManualImport.new(resource_params[0])

      @manual_import.import if @manual_import.valid?

      render :new
    end
  end
end

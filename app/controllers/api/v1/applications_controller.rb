class Api::V1::ApplicationsController < ApiController
  before_action :authenticate_client!
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /api/v1/applications
  def index
    @applications = Application.all

    render json: @applications
  end

  # GET /api/v1/applications/1
  def show
    render json: @application
  end

  # POST /api/v1/applications
  def create
    @application = Application.new(application_params)
    @application.client = current_client
    if @application.save
      render json: {app_token:@application.token}, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/applications/1
  def update
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end

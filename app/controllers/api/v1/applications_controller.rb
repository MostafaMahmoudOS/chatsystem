class Api::V1::ApplicationsController < ApiController
  before_action :authenticate_client!
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /api/v1/applications
  def index
    @applications = Application.where("client_id",current_client.id)
    render json: @applications
  end

  # GET /api/v1/applications/:token
  def show
    if @application
      render json: @application
    else  
      render json: {error:"Application Not Found"}, status: :not_found
    end
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

  # PATCH/PUT /api/v1/applications/:token
  def update
    if @application
      if @application.update(application_params)
        render json: @application
      else
        render json: @application.errors, status: :unprocessable_entity
      end
    else  
      render json: {error:"Application Not Found"}, status: :not_found
    end
  end

  # DELETE /api/v1/applications/:token
  def destroy
    if @application
      @application.destroy
    else  
      render json: {error:"Application Not Found"}, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(client_id:current_client.id,token: params[:token])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end

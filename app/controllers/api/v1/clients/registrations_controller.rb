class Api::V1::Clients::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  def create
      @client = Client.new(sign_up_params)
      if @client.save
        render json: @client
      else
        render json: { errors: @client.errors }
      end
  end
  private
  def sign_up_params
      params.permit(:email, :password, :password_confirmation)
  end
end
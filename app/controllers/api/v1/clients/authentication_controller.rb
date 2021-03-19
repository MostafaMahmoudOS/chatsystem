class Api::V1::Clients::AuthenticationController < ApiController
    before_action :authenticate_client!
    skip_before_action :authenticate_client!, only: [:create]
    
    def create
        client = Client.find_by(email: params[:email])
        puts client
        if client&.valid_password?(params[:password])
            render json: { token: JsonWebToken.encode(sub: client.id,type: "client") }
        else
            render json: { errors: 'invalid' }
        end
    end
    def fetch
        render json: current_client
    end
end 
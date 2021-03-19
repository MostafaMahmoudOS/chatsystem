class Api::V1::Users::AuthenticationController < ApiController
    before_action :authenticate_blogger!
    skip_before_action :authenticate_blogger!, only: [:create]
    def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
            render json: { token: JsonWebToken.encode(sub: user.id,type: "user") }
        else
            render json: { errors: 'invalid' }
        end
    end
    def fetch
        render json: current_user
    end
end 
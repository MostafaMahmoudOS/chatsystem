class Api::V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :set_application, only: [:create]
  before_action :authenticate_client!

  # GET /api/v1/applications/:application_token/chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /api/v1/applications/:application_token/1
  def show
    render json: @chat
  end

  # POST /api/v1/applications/:application_token/chats
  def create
    if @application
      @chat = Chat.new(name: chat_params[:name],application:@application)
      @chat.users=User.where(code: chat_params[:members_codes]);
      if @chat.save
        render json: @chat, status: :created
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    else
      render json: {error: "Application NotFound"}, status: :unprocessable_entity
    end  
    
  end

  # PATCH/PUT /api/v1/applications/:application_token/:chat_number/
  def update
    if @chat.update(chat_update_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end
  # PATCH/PUT /api/v1/applications/:application_token/appliction_token/:chat_number/member
  def addChatMember
    if @chat.update(chat_update_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end
  # DELETE /api/v1/applications/:application_token/appliction_token/:chat_number/member
  def removeChatMember
    if @chat.update(chat_update_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end
  # DELETE /api/v1/applications/:application_token/appliction_token/:chat_number
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find_by(appliction_token: params[:application_token],chat_number: params[:chat_number])
    end
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end
    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:name,:members_codes=>[])
    end
    def chat_update_params
      params.require(:chat).permit(:name)
    end
    def chat_member_params
      params.require(:chat).permit(:member_id)
    end
end

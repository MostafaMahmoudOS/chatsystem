class Api::V1::ChatsController < ApplicationController
  before_action :authenticate_client!
  before_action :set_application
  before_action :set_chat, only: [:show, :update, :destroy,:addChatMember,:removeChatMember]
  before_action :chat_member_params, only: [:addChatMember,:removeChatMember]
  before_action :set_chat_member, only: [:addChatMember,:removeChatMember]

  # GET /api/v1/applications/:token/chats
  def index
    if @application
      @chats = Chat.where("application_id",@application.id)
      render json: @chats
    else 
      render json: {error:"Application Not Found"}, status: :not_found
    end  
  end

  # GET /api/v1/applications/:application_token/chats/:number/
  def show
    puts @chat.chat_number
    if @chat
      render json: @chat
    else 
      render json: {error:"Chat Not Found"}, status: :not_found
    end
  end

  # POST /api/v1/applications/:application_token/chats/
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

  # PATCH/PUT /api/v1/applications/:application_token/chats/:number/
  def update
    if @chat.update(chat_update_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end
  # PATCH/PUT /api/v1/applications/:application_token/chats/:number/member
  def addChatMember
    if @chat
      if @member
        if @chat.users.exists?(@member.id)
          render json:  {error: "Member already exist"}, status: :unprocessable_entity
        else
          @chat.users << @member
          render json: @chat
        end
      else
        render json: {error: "Member NotFound"}, status: :unprocessable_entity
      end
    else
      render json: {error: "Chat NotFound"}, status: :unprocessable_entity
    end
  end
  # DELETE /api/v1/applications/:application_token/appliction_token/:number/member
  def removeChatMember
    if @chat
      if @member
        if @chat.users.exists?(@member.id)
           @chat.users.delete(@member)
           render json: @chat
        else
          render json:  {error: "Member Not exist in chat"}, status: :unprocessable_entity
        end
      else
        render json: {error: "Member NotFound"}, status: :unprocessable_entity
      end
    else
      render json: {error: "Chat NotFound"}, status: :unprocessable_entity
    end
  end
  # DELETE /api/v1/applications/:application_token/appliction_token/:number
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      if @application
        @chat = Chat.find_by(application: @application.id,chat_number: params[:number])
      else 
        @chat = nil
      end    
    end
    def set_application
      @application = Application.find_by(client_id:current_client.id,token: params[:application_token])
    end
    def set_chat_member
      puts params
      @member = User.find_by(code: params[:chat][:member_id])
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

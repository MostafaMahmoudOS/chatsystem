class Api::V1::MessagesController < ApiController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :set_application, only: [:create,:index]
  before_action :set_chat, only: [:create,:index]
  before_action :search_params, only: [:index]
  # GET /messages
  def index
    unless params[:q].blank?
      puts @chat.id
      @messages = @chat ? Message.search(search_params[:q],@chat.id).records : []
    else
      @messages=[]
    end  
    render json: @messages , root: 'messages'
  end


  # POST /messages
  def create
    if @chat
      @message = Message.new(body: message_params[:body],chat: @chat)
      @message.sender = current_user
      if @message.save
        render json: @message, status: :created
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    else 
      render json: {error: "Chat NotFound"}, status: :unprocessable_entity
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:body)
    end
    def set_chat
      if @application
        @chat = Chat.find_by(application: @application.id,chat_number: params[:chat_number])
        if @chat
          if @chat.users.exists?(current_user.id) 
            @chat=@chat
          else 
            @chat=nil
          end  
        end
      else 
        @chat=nil
      end
    end  
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end
    def search_params
      params.permit(:q)
    end
end

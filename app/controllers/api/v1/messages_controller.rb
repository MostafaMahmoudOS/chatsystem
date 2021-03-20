class Api::V1::MessagesController < ApiController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :set_application, only: [:create]
  before_action :set_chat, only: [:create]

  # GET /messages
  def index
    @messages = Message.search('foobar').records
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
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

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
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
      else 
        @chat=nil
      end
    end  
    def set_application
      @application = Application.find_by(token: params[:application_token])
    end

end

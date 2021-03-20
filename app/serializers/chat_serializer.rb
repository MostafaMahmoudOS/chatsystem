class ChatSerializer < ActiveModel::Serializer
    attributes :name, :chat_number ,:messages_count,:members,:messages
    def messages
        ActiveModel::SerializableResource.new(object.messages,each_serializer: MessageSerializer) 
    end 
    def members
        ActiveModel::SerializableResource.new(object.users,each_serializer: UserSerializer) 
    end 
end
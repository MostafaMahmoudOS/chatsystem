class MessageSerializer < ActiveModel::Serializer
    attributes :body,:message_number, :sender
    def sender
        {
            email: self.object.sender.email
        }
    end 
end
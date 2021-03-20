class ApplicationSerializer < ActiveModel::Serializer
    attributes :name, :token ,:chats_count,:client
    def client
        {
            email: self.object.client.email
        }
    end 
end
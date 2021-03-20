class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :sender, class_name: :User
    belongs_to :chat
    before_create :set_message_number
    def set_message_number
        self.message_number= (self.chat.messages.count)+1;
    end
end

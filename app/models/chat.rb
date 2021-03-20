class Chat < ApplicationRecord
    belongs_to :application
    has_and_belongs_to_many :users
    before_create :set_chat_number
    validates :application_id,:name ,presence: true
    validates :name, :uniqueness => true
    has_many :messages
    def set_chat_number
        self.chat_number= (self.application.chats.count)+1;
    end
end

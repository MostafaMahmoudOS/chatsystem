class Chat < ApplicationRecord
    validates :application_id,:name ,presence: true
    validates :name, uniqueness: { scope: :application_id }, on: :create
    validates :name, uniqueness: { scope: :application_id }, on: :update,if: :name_changed?

    belongs_to :application
    has_many :messages
    has_and_belongs_to_many :users

    before_create :set_chat_number

    def set_chat_number
        self.chat_number= (self.application.chats.count)+1;
    end
    
end

class MessagesCountingJob < ApplicationJob
    queue_as :default

    def perform(chat_id)
        @chat=Chat.find(chat_id)
        new_count=@chat.messages_count+1
        @chat.messages_count = new_count
        @chat.save
        puts "New messages count "+@chat.messages_count.to_s
    end
end
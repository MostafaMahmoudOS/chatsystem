class ChatsCountingJob < ApplicationJob
    queue_as :default
  
    def perform(application_id)
        @application=Application.find(application_id)
        @application.chats_count=@application.chats_count+1
        @application.save
        puts "New chats count "+@application.chats_count.to_s
    end
end
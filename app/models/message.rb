class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    belongs_to :sender, class_name: :User
    belongs_to :chat

    validates :body ,presence: true

    before_create :set_message_number
    after_create :update_chats_count

    def set_message_number
        self.message_number= (self.chat.messages.count)+1;
    end

    settings do
        mappings dynamic: false do
          indexes :body, type: :text, analyzer: :english
          indexes :chat_id, type: :integer
        end
    end

    def self.search(query,chat_id)
        __elasticsearch__.search(
          "query": {
            "bool": {
              "must": {
                "query_string": {"query": "*#{query}*",fields: ['body'] }
              },
              "filter": {
                "term": {
                  "chat_id": chat_id
                }
              }
            }
          }
        )
    end

    def update_chats_count
      MessagesCountingJob.perform_later(self.chat.id)
    end
end

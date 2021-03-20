class Application < ApplicationRecord
  belongs_to :client
  validates :name, presence: true
  before_create :set_token
  def set_token
    self.token = DateTime.now.strftime('%s').concat(SecureRandom.base64(24))
  end
end

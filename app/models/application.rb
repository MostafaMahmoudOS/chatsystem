class Application < ApplicationRecord
  belongs_to :client
  has_many :chats
  validates :name, presence: true
  validates :name, uniqueness: true, on: :create
  validates :name, uniqueness: true, on: :update,if: :name_changed?
  before_create :set_token
  def set_token
    self.token = DateTime.now.strftime('%s').concat(SecureRandom.hex)
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  before_create :set_code
  def set_code
    self.code = DateTime.now.strftime('%s').concat(SecureRandom.hex(8))
  end       
end

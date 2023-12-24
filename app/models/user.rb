class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  :trackable and :omniauthable
  before_create :default_image
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
    has_many :reservations, dependent: :destroy
    has_many :rooms, dependent: :destroy

def default_image
  if !self.image.attached?
    self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar_sample.png')), filename: 'avatar_sample.png', content_type: 'image/png')
  end
end


end

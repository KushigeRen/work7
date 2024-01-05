class Room < ApplicationRecord
  before_create :default_image
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true,length: {maximum: 20}
  validates :detail, presence: true, length: {maximum: 200}
  validates :fee, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1},length: {maximum: 8}
  validates :address, presence: true, length: {maximum: 100}

  # 住所部分一致検索
  def self.find_by_address(room_address)
    return Room.where("address LIKE?","%#{room_address}%")
  end

  # 施設名部分一致検索
  def self.find_by_name(room_name)
    return Room.where("name LIKE?","%#{room_name}%")
  end

  # 住所・施設名部分一致AND検索
  def self.find_by_name_address(room_name,room_address)
    return Room.where("name LIKE ? AND address LIKE ?","%#{room_name}%","%#{room_address}%")
  end

  # 各ユーザが登録した施設の一覧取得
  def self.registered_room(user_id)
    return Room.where("user_id = ?", "#{user_id}")
  end

  # 新規登録時部屋画像未設定の場合デフォルト画像挿入
  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'room_sample.png')), filename: 'room_sample.png', content_type: 'image/png')
    end
  end

  # 数値を３桁ごとにカンマ区切りする関数
  def delimiter(num)
    return num.to_s(:delimited)
  end
end

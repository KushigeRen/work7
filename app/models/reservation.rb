class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, :check_out_date, presence: true
  validates :number_of_guests, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1},length: {maximum: 2}
  
  # 各ユーザが予約した施設の一覧取得
  def self.reservation_room(user_id)
    return Reservation.where("user_id = ?", "#{user_id}")
  end
end

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :inconsistent_date
  validates :check_in_date, :check_out_date, presence: true
  validates :number_of_guests, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1},length: {maximum: 2}

  # 各ユーザが予約した施設の一覧取得
  def self.reservation_room(user_id)
    return Reservation.where("user_id = ?", "#{user_id}")
  end

  # 金額をカンマ区切りにする関数
  def delimiter(num)
    return num.to_s(:delimited)
  end

  def inconsistent_date
    if check_in_date >= check_out_date
      $room.errors.add(:check_out_date,'はチェックイン日より後の日付を設定してください。')
    end
    if check_in_date < Date.today
      $room.errors.add(:check_in_date, "は今日以降の日付を選択してください")
    end
  end
end

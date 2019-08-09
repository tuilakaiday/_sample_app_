class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.length_text}
  validate  :picture_size

  scope :feed, ->(ids){where(user_id: ids)}
  scope :order_by, ->{order(created_at: :desc)}

  private
  def picture_size
    if picture.size > Settings.limmit_size_pic.megabytes
      errors.add(:picture, I18n.t(".limmit_size_pic"))
    end
  end
end

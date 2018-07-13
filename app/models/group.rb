class Group < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name creator_id picture).freeze

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts

  mount_uploader :picture, PictureUploader

  validates :name, presence: true

  scope :order_by_time, -> {order created_at: :desc}

  def order_post_by_time
    posts.order_by_time
  end
end

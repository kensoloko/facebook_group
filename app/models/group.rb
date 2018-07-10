class Group < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name creator_id).freeze

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts

  validates :name, presence: true

  scope :order_by_time, -> {order created_at: :desc}
end

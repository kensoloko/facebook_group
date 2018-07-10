class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :posts

  validates :name, presence: true

  scope :order_by_time, -> {order created_at: :desc}
end

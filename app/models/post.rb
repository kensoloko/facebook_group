class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_many :comments, dependent: :destroy

  validates :content, presence: true

  scope :order_by_time, ->{order created_at: :desc}
  scope :user_profile_posts, lambda {|current_user_id|
    joins(:user).where(group_id: nil, users: {id: current_user_id})}
end

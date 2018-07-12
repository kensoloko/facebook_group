class Post < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(content group_id picture).freeze

  belongs_to :user
  belongs_to :group, optional: true

  has_many :comments, dependent: :destroy

  validates :content, presence: true

  mount_uploader :picture, PictureUploader

  scope :order_by_time, ->{order created_at: :desc}
  scope :user_profile_posts, (lambda do |current_user_id|
    joins(:user).where(users: {id: current_user_id})
      .order created_at: :desc
  end)
  scope :not_in_group, ->{where group_id: nil}

  def find_comments_root_post
    comments.where(parent_id: nil).order created_at: :desc
  end

  def belong_to? user
    self.user_id == user.id
  end
end

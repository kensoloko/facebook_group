class UserGroup < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(group_id).freeze

  belongs_to :group
  belongs_to :user
end

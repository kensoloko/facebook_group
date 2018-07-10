class UserGroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @membership = current_user.user_groups.build user_group_params
    if membership.save
      flash[:sucess] = t "messages.join_group"
    else
      flash[:danger] = t "messages.join_group_fail"
    end
    redirect_to groups_path
  end

  private

  attr_reader :membership

  def user_group_params
    params.require(:user_group).permit UserGroup::ATTRIBUTE_PARAMS
  end
end

class UserGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_view_support, only: %i(create)

  def create
    group = Group.find_by id: params[:user_group][:group_id]
    @membership = current_user.user_groups.build user_group_params
    if membership.save
      respond_to do |format|
        format.html {redirect_to group}
        format.js
      end
    end
  end

  def destroy
    current_group = Group.find_by id: params[:user_group][:group_id]
    group = UserGroup.find_by id: params[:id]
    current_user.leave(group)
    respond_to do |format|
      format.html {redirect_to current_group}
      format.js
    end
  end

  private

  attr_reader :membership

  def user_group_params
    params.require(:user_group).permit UserGroup::ATTRIBUTE_PARAMS
  end

  def load_view_support
    @support = Supports::ViewSupport.new current_user: current_user
  end
end

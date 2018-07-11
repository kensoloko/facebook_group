class GroupsController < ApplicationController
  before_action :load_group, only: %i(show destroy edit update)

  def index
    @groups = Group.includes(:posts, :users).order_by_time.page(params[:page]).
      per(Settings.group_per_page)
  end

  def new
    @group = Group.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @group = Group.new group_params
    group.users << current_user
    if group.save
      flash[:sucesss] = t "messages.created_group"
    else
      flash[:danger] = t "messages.create_group_fail"
    end
    redirect_to groups_path
  end

  def show
    @leave_group = current_user.user_groups.find_by group_id: @group.id
  end

  def edit; end

  def update
    if group.update_attributes group_params
      flash[:sucess] = t "messages.update_group"
    else
      flash[:danger] = t "messages.update_group_fail"
    end
    redirect_to groups_path
  end

  def destroy
    if group.destroy
      respond_to do |format|
        format.html {redirect_to groups_path}
        format.js
      end
    end
  end

  private

  attr_reader :group

  def group_params
    params.require(:group).permit Group::ATTRIBUTE_PARAMS
  end

  def load_group
    @group = Group.find_by id: params[:id]

    return if group
    flash[:danger] = t "messages.not_found", id: params[:id]
    redirect_to groups_path
  end
end

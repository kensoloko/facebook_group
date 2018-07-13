class GroupsController < ApplicationController
  before_action :load_group, only: %i(show destroy edit update)
  before_action :load_view_support, only: %i(show)

  def index
    @groups = Group.includes(:posts, :users).order_by_time.page(params[:page]).
      per Settings.group_per_page
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
    if signed_in?
      @leave_group = current_user.user_groups.find_by group_id: @group.id
    end
    @posts = @group.order_post_by_time.includes(:user, :comments).
      page(params[:page]).per Settings.post_per_page
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

  def load_view_support
    @support = Supports::ViewSupport.new current_user: current_user
  end

  def load_group
    @group = Group.find_by id: params[:id]

    return if group
    flash[:danger] = t "messages.not_found", id: params[:id]
    redirect_to groups_path
  end
end

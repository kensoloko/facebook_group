class GroupsController < ApplicationController
  before_action :load_group, only: %i(show destroy)

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
    if group.save
      flash[:sucesss] = t "messages.created_group"
    else
      flash[:danger] = t "messages.create_group_fail"
    end
    redirect_to groups_path
  end

  def show; end

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
    params.require(:group).permit :name, :creator_id
  end

  def load_group
    @group = Group.find_by id: params[:id]

    return if group
    flash[:danger] = t "messages.not_found", id: params[:id]
    redirect_to groups_path
  end
end

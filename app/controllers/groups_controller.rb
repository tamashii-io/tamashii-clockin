# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :user_admin?
  before_action :find_group, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    return redirect_to groups_path, notice: 'create success' if @group.save
  end

  def edit; end

  def update
    return redirect_to groups_path, notice: 'update success' if @group.update_attributes(group_params)
    render :edit
  end

  def destroy
    return redirect_to groups_path, notice: 'destroy success' if @group.destroy
  end

  private
  def user_admin?
    redirect_to users_admin_index_path, notice: 'invalid user' unless current_user.admin?
  end

  def group_params
    params.require(:group).permit(:title, :join_time)
  end

  def find_group
    @group = Group.all.find(params[:id])
  end
end

# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :user_admin?, except: :index

  def index
     @groups =  Group.all
  end

  def new
     @group =  Group.new
  end

  def create
     @group =  Group.new(group_params)
      return redirect_to memberships_path, notice: 'create success' if @group.save
  end

  def edit; end

  def update
    return redirect_to memberships_path, notice: 'update success' if update_user(@group)
    render :edit
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:title, :join_time)
  end
end

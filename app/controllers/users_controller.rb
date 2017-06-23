# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true
    return redirect_to users_admin_index_path, notice: 'create success' if @user.save
    render :new
  end

  def edit; end

  def update
    return redirect_to users_admin_index_path, notice: 'update success' if @user.update_attributes(user_params)
    render :edit
  end

  def destroy
    @user.destroy
    redirect_to users_admin_index_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :card_serial)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

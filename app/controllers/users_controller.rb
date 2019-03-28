# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_admin?, except: :index
  before_action :find_user, only: [:edit, :update, :destroy, :recover]
  def index
    @users = User.all.unscoped

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
    return redirect_to users_admin_index_path, notice: 'create success' if @user.save
    render :new
  end

  def edit; end

  def update
    return redirect_to users_admin_index_path, notice: 'update success' if update_user(@user)
    render :edit
  end

  def destroy
    @user.update_without_password(deleted: true, card_serial: '')
    redirect_to users_admin_index_path
  end

  def recover
    @user.update_without_password(deleted: false)
    redirect_to users_admin_index_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :job_type, :card_serial, :password, group_ids: [])
  end

  def find_user
    @user = User.all.unscoped.find(params[:id])
  end

  def user_admin?
    redirect_to users_admin_index_path, notice: 'invalid user' unless current_user.admin?
  end

  def update_user(user)
    return user.update_without_password(user_params) if user_params.fetch(:password, '').blank?
    user.update(user_params)
  end
end

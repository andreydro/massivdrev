# frozen_string_literal: true

# class for Orders Controller
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: I18n.t('users.created')
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to users_path, notice: I18n.t('users.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, notice: I18n.t('users.deleted')
    else
      redirect_to users_path, notice: I18n.t('users.is_not_deleted')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end

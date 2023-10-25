# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: %i[index new create]
  before_action :require_editor_permissions, only: %i[edit update]
  before_action :require_owner_permissions, only: [:destroy]

  def index
    @passwords = current_user.passwords
  end

  def new
    @password = Password.new
  end

  def create
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user, role: :owner)

    if @password.save
      redirect_to @password, notice: 'Password created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @password.update(password_params)
      redirect_to @password, notice: 'Password updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy
    redirect_to passwords_path, notice: 'Password deleted!'
  end

  private

  def password_params
    params.require(:password).permit(:url, :username, :password)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])

    @user_password = current_user.user_passwords.find_by(password: @password)
  end

  def require_editor_permissions
    redirect_to @password, alert: "You don't have permissions to do that." unless user_password.editable?
  end

  def require_owner_permissions
    redirect_to @password, alert: "You don't have permissions to do that." unless user_password.deletable?
  end
end

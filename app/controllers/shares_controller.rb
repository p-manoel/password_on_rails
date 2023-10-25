# frozen_string_literal: true

class SharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password

  def new
    @users = User.excluding(@password.users)
    @user_password = UserPassword.new
  end

  def create
    @user_password = @password.user_passwords.new(user_password_params)

    if @user_password.save
      redirect_to @password, notice: 'Credentials has been shared.'
    else
      @users = User.excluding(@password.users)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @password.user_passwords.find_by(user_id: params[:id]).destroy

    redirect_to @password, notice: 'Credentials has been unshared with the user.'
  end

  private

  def set_password
    @password = current_user.passwords.find(params[:password_id])
  end

  def user_password_params
    params.require(:user_password).permit(:user_id, :role)
  end
end

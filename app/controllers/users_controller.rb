class UsersController < ApplicationController
  before_action :set_user, only: [:show, :new, :edit, :update, :destroy]

  def index
    @users = User.all
    response_block @users
  end

  def show
    @user
  end

  def new
    @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      response_block @user
    else
      response_block @user.errors.full_messages if @user.errors.any?
    end
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      response_block @user
    else
      response_block @user.errors.full_messages if @user.errors.any?
    end
  end

  def destroy
    if @user.destroy
      response_block @user
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:nick_name, :password, :email)
  end

  def response_block(data)
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end
end

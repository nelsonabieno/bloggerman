class UsersController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  before_action :set_user, only: [:show, :new, :edit, :update, :destroy]

  def index
    @users = User.all
    response_handler @users
  end

  def show
    @user
    response_handler @user
  end

  def new
    @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      response_handler @user
    else
      response_handler @user.errors.full_messages if @user.errors.any?
    end
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      response_handler @user
    else
      response_handler @user.errors.full_messages if @user.errors.any?
    end
  end

  def destroy
    if @user.destroy
      response_handler @user
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:nickname, :password, :email)
  end

  def response_handler(data)
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end
end

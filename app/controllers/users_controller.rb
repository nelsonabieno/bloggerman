class UsersController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    response_handler @users
  end

  def show
    @user
    response_handler @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      response_handler @user
      flash[:success] = "User #{@user.nickname} successfully created"
      redirect_to users_path
    else
      @error = @user.errors.full_messages if @user.errors.any?
      response_handler @error
      render 'users/new'
    end
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User #{@user.nickname} successfully updated"
      update_destroy_response
    else
      @error = @user.errors.full_messages if @user.errors.any?
      render 'users/edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User #{@user.nickname} successfully destroyed!"
      update_destroy_response
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :password, :email)
  end

  def response_handler(data)
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end

  def update_destroy_response
    respond_to do |format|
      format.json { render json: { user: @user, message: "#{flash[:success]}" } }
      format.html { redirect_to users_path }
    end
  end
end

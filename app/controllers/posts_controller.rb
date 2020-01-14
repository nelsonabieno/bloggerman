class PostsController < ApplicationController
  before_action :find_user, only: [:new, :index,:edit]
  before_action :find_user_post, only: [:update,:destroy]

  def index
    @user
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to user_posts_path
    else
      flash[:error] = @post.errors.full_messages
      render 'posts/new'
    end
  end

  def edit
    @post = @user.posts.find(params[:id])

    if @post.nil?
      flash[:error] = ['Sorry We couldn\'t find the post for this user']
      redirect_to user_posts_path
    end
  end

  def update
    if @user_post.update(post_params)
      flash[:success] = 'Post successfully updated'
      redirect_to user_posts_path
    end

    #TODO else block
  end

  def destroy
    if @user_post.destroy
      flash[:success] = 'Post successfully deleted'
      redirect_to user_posts_path
    end
  end

  private

  def find_user_post
    @user_post = Post.find(params[:id])

    if @user_post.nil?
      flash[:error] = ['Sorry We couldn\'t find the post for this user']
      redirect_to user_posts_path
    end

  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def response_handler data
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :like, :unlike, :user_id)
  end
end

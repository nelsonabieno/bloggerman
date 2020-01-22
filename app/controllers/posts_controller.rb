class PostsController < ApplicationController
  before_action :find_user, only: [:create, :new, :index,:edit, :update, :show]
  before_action :find_user_post, only: [:update,:destroy, :show]

  def index
    @user
    response_handler @user.posts
  end

  def new
    @post = Post.new
  end

  def show
    @user
    @post = @user.posts.find(params[:id])
    response_handler @user_post
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]

    if @post.save
      flash[:success] = 'Post successfully created'
      respond_to do |format|
        format.json { response_handler @post  }
        format.html { redirect_to user_posts_path }
      end
    else
      flash[:error] = @post.errors.full_messages
      respond_to do |format|
        format.json { render json: { error: flash[:error] } }
        format.html { render 'posts/new' }
      end
    end
  end

  def edit
    @post = @user.posts.find(params[:id])

    if @post.nil?
      flash[:error] = ['Sorry We couldn\'t find the post for this user']
      response_handler flash[:error]
      redirect_to user_posts_path
    end
  end

  def update
    @post = @user.posts.find(params[:id])

    if @user_post.update(post_params)
      flash[:success] = 'Post successfully updated'
      respond_to do |format|
        format.json { response_handler @user_post  }
        format.html { redirect_to user_posts_path }
      end
    else
      flash[:error] = @user_post.errors.full_messages
      respond_to do |format|
        format.json { render json: { error: flash[:error] } }
        format.html { render 'posts/edit' }
      end
    end
  end

  def destroy
    if @user_post.destroy
      flash[:success] = 'Post successfully deleted'
      respond_to do |format|
        format.json { render json: flash[:success] }
        format.html { redirect_to user_posts_path }
      end
    end
  end

  private

  def find_user_post
    @user_post = Post.find(params[:id])

    if @user_post.nil?
      flash[:error] = ['Sorry We couldn\'t find the post for this user']
      response_handler flash[:error]
      redirect_to user_posts_path
    end
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def response_handler data
    respond_to do |format|
      format.json { render json: data  and return}
      format.html
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :like, :unlike, :user_id)
  end
end

class CommentsController < ApplicationController
  before_action :find_user,:find_post, only: [:new, :index, :edit, :show, :update]
  before_action :find_post, only: [:new, :index, :create, :edit]
  before_action :find_post_comment, only: [:update,:destroy, :show]

  def index
    @comments = @user.posts.find(params[:post_id]).comments
    response_handler @comments
  end

  def show
    response_handler @post_comment
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = params[:user_id]

    if @comment.save
      flash[:success] = 'Comment successfully created'
      respond_to do |format|
        format.html { redirect_to user_post_comments_path }
        format.json  { render json: @comment, status: :created }
      end
    else
      flash[:error] = @comment.errors.full_messages
      respond_to do |format|
        format.json { render json: flash[:error]  }
        format.html { render 'new' }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])

    if @comment.nil?
      flash[:error] = ['Sorry We couldn\'t find the comment for this post']
      redirect_to user_post_comments_path
    end
  end

  def update
    @comment = @post.comments.find(params[:id])

    if @post_comment.update(comment_params)
      flash[:success] = 'Comment successfully updated'
      respond_to do |format|
        format.html { redirect_to user_post_comments_path }
        format.json  { render json: @post_comment, status: :created }
      end
    else
      flash[:error] = @post_comment.errors.full_messages
      respond_to do |format|
        format.json { render json: { error: flash[:error] }  }
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    if @post_comment.destroy
      flash[:success] = 'Comment successfully deleted'

      respond_to do |format|
        format.html { redirect_to user_post_comments_path }
        format.json  { render json: @post_comment, status: :ok }
      end

    end
  end

  private

  def find_user_posts
    @posts = @user.posts
  end

  def find_post_comments
    @comments = @posts.comments
  end

  def find_post_comment
    find_post
    @post_comment = @post.comments.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end

  def response_handler data
    respond_to do |format|
      format.json { render json: data  }
      format.html
    end
  end
end

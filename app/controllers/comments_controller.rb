class CommentsController < ApplicationController
  before_action :find_user,:find_post, only: [:new, :index, :edit]
  before_action :find_post, only: [:new, :index, :create, :edit]
  before_action :find_post_comment, only: [:update,:destroy]

  def index
    # binding.pry
    @comments = @user.posts.find(params[:post_id]).comments
    # find_post_comments
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    # @comment.user_id = params[:user_id]

    if @comment.save
      flash[:success] = 'Comment successfully created'
      # binding.pry
      redirect_to user_post_comments_path
    else
      # binding.pry
      flash[:error] = @comment.errors.full_messages
      render 'new'
    end
  end

  def edit
    # binding.pry
    @comment = @post.comments.find(params[:id])

    if @comment.nil?
      flash[:error] = ['Sorry We couldn\'t find the comment for this post']
      redirect_to user_post_comments_path
    end
  end

  def update
    if @post_comment.update(comment_params)
      flash[:success] = 'Comment successfully updated'
      redirect_to user_post_comments_path
    end
  end

  def destroy
    if @post_comment.destroy
      flash[:success] = 'Comment successfully deleted'
      redirect_to user_post_comments_path
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
end

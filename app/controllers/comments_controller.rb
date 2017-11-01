class CommentsController < ApplicationController

  before_action :logged_in_user
  before_action :get_post
  before_action :get_comment, except: :create
  before_action :admin_or_correct_user, except: :create

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    respond_to do |format|
      format.html {
        if @comment.save
          flash[:success] = "Comment is created"
          redirect_to @post
        else
          flash[:danger] = "Comment wasn't created"
          redirect_to @post
        end
      }
      format.js {
        @comment.save
      }
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      format.js { @comment.update_attributes(comment_params) }
    end
  end

  def destroy
    @id = params[:id]
    @comment.destroy
    @count = @post.comments.count
    respond_to do |format|
      format.html {
        flash[:success] = "Comment has been successfully deleted"
        redirect_to @post
      }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def get_post
      @post = Post.find(params[:post_id])
    end

    def get_comment
      @comment = Comment.find(params[:id])
    end

    def admin_or_correct_user
      if current_user.nil? && !(current_user.admin? || current_user?(@comment.user))
        redirect_to root_url
      end
    end

end

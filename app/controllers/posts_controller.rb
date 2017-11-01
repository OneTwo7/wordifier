class PostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:create, :edit, :update, :destroy]

  def index
    @post = Post.new
    @posts = Post.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.limit(10)
  end

  def create
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      format.html {
        if @post.save
          flash[:success] = "Post successfully created"
          redirect_to posts_url
        else
          render 'index'
        end
      }
      format.js
    end
  end

  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html {
        if @post.update_attributes(post_params)
          flash[:success] = "Post successfully updated"
          redirect_to posts_url
        else
          render 'index'
        end
      }
      format.js {
        @post.update_attributes(post_params)
      }
    end
  end

  def destroy
    @id = params[:id]
    Post.find(params[:id]).destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Post has been successfully deleted"
        redirect_to posts_url
      }
      format.js
    end
  end

  def load_more
    @post = Post.find(params[:post_id])
    offset = params[:offset].to_i
    @comments = @post.comments.offset(offset * 10).limit(10)
    @href = "/load_more?offset=#{offset + 1}&post_id=#{params[:post_id]}"
    respond_to do |format|
      format.js
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

end

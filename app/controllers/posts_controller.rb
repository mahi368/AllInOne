class PostsController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  def index   
      @query = Post.ransack(params[:q])
      @posts =  @query.result
  end

  def new
    @post = Post.new
  end

  def create
    @post =  current_user.posts.new(caption: params[:post][:caption], category_id: params[:post][:category_id])
    @post.save
    if params[:post][:avatar].present?
      params[:post][:avatar].each do |image|
        byebug
        @image = @post.images.new(avatar: image)
        @image.save
      end
    end
    redirect_to posts_path
    @posts = Post.all 
  end

  def show
    @comments = @post.comments.parent_id_nil
    @image = @post.images.paginate(page: params[:page], per_page: 1 )
  end

  def edit
  end

  def update
    @post.images.destroy_all
    if params[:post][:avatar].present?.eql?("true")
      params[:post][:avatar].each do |image|
        @image = @post.images.new(avatar: image)
        @image.save
      end 
    end
    @post.update(caption: params[:post][:caption],category_id: params[:post][:category_id])
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def create_comment
      @post = Post.find(params[:comment][:post_id])
      @comment =  @post.comments.new(feedback: params[:comment][:feedback] , user_id: current_user.id)
      @comment.save
      @comments = @post.comments.parent_id_nil
  end

  def destroy_comment
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    @comments = @comment.post.comments.parent_id_nil
  end

  def like_dislike
    @comment = Comment.find(params[:comment_id])
    if params["like"] == "true"
      @like = @comment.likes.new(user_id: current_user.id)
      @like.save
    else
      @comment.likes.find_by(user_id: current_user.id).destroy
    end
  end

  def create_reply
    @comment = Comment.find(params[:parent_id])
    @post = @comment.post
    @reply = @comment.comments.new(feedback: params[:comment][:feedback], post_id: @post.id , user_id: current_user.id)
    @reply.save
    # redirect_to post_path(@post.id)
  end

  def delete_reply
     @comment = Comment.find(params[:comment_id]) 
     @comment.destroy
     @post = Post.find(params[:post_id])
     @comments = @post.comments.parent_id_nil
  end
  
  private
  def set_category
      @post = Post.find(params[:id])
  end
end

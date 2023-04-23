# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to @post
    else
      flash.now[:error] = 'There was an error creating the post.'
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post was successfully updated.'
      redirect_to @post
    else
      flash.now[:error] = 'There was an error updating the post.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post was successfully deleted.'
    redirect_to posts_url
  end

  def share_to_facebook
    @post = Post.find(params[:id])

    # Authenticate the user and obtain a valid access token
    # using the Facebook Graph API
    access_token = get_facebook_access_token(current_user)

    # Create a new Facebook API client object
    client = FacebookClient.new(access_token)

    # Post the message to the user's Facebook feed
    client.post_message(@post.message)

    flash[:success] = 'Post shared on Facebook successfully!'
    redirect_to @post
  rescue FacebookAuthenticationError => e
    flash[:error] = 'There was an error sharing the post on Facebook.'
    redirect_to @post
  end

  def share_to_twitter
    @post = Post.find(params[:id])

    # Authenticate the user and obtain a valid access token
    # using the Twitter API
    access_token = get_twitter_access_token(current_user)

    # Create a new Twitter API client object
    client = TwitterClient.new(access_token)

    # Post the message to the user's Twitter feed
    client.post_tweet(@post.message)

    flash[:success] = 'Post shared on Twitter successfully!'
    redirect_to @post
  rescue TwitterAuthenticationError => e
    flash[:error] = 'There was an error sharing the post on Twitter.'
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :message, :image)
  end
end

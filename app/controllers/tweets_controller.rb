class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!



  # GET /tweets
  # GET /tweets.json
  def index

      #@tweets = current_user.tweets
      @tweets = Tweet.order("created_at DESC").page(params[:page])
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show

  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    tweet = Tweet.find(params[:tweet_id])
    if Like.exists?(tweet_id: params[:tweet_id],user_id: current_user.id)
      flash[:notice] = "You can't like more than once"
      redirect_to '/tweets#index'
    else
      tweet.likes.create(user_id: current_user.id)
      redirect_to '/tweets#index'
    end
  end

  def retweet
    #@retweet = Tweet.create(content:@tweet.content, user: current_user, tweet_id: @tweet.id)
    tweet = current_user.tweets.new(tweet_id: @tweet.id)
    if tweet.save
      redirect_to tweets_path
    else
      redirect_to :back, alert: "Unable to retweet"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content , :user_id , :tweet_id)
    end
end

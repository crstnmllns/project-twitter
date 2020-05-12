class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  # GET /tweets
  # GET /tweets.json
  def index
    @q = Tweet.ransack(params[:q])
    @tweets = @q.result(distinct: true).order("created_at DESC").page(params[:page])

    @tweets.map do |tweet|
      tweet.content = hashtags(tweet)
      tweet.content
    end



      #@tweets = current_user.tweets
      #@tweets = Tweet.order("created_at DESC").page(params[:page])

      #@tweet_amount = Tweet.tweet_amount
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @likes = Like.joins(:user).where(tweet_id: @tweet.id)


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
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = Tweet.create(content: @tweet.content , user: current_user , tweet_id: @tweet.id)
    #if @retweet.save
    #  redirect_to root_path, notice: 'Your Retweet was successfully published.'
    #end
    #tweet.tweets.new(content: @tweet.content , user: current_user ,tweet_id: @tweet.id)
    #@retweet = Tweet.create(content: tweet.content, user: current_user, tweet_id: tweet.id)
    #tweet = current_user.tweets.new(content: @tweet.content , tweet_id: @tweet.id)
    #if tweet.save
    #  redirect_to tweets_path
    #else
    #  redirect_to :back, alert: "Unable to retweet"
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def hashtags(tweet)
      content_arr = tweet.content.split(' ')
      modified_content = content_arr.map { |word| word.starts_with?("#") ? "<a href='" + tweets_path + "?utf8=✓&q%5Bcontent_cont%5D=#{word}&commit=Search' class=''>#{word}</a>" : word }
      modified_content.join(' ')
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content , :user_id , :tweet_id)
    end
end

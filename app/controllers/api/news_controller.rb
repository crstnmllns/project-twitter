class Api::NewsController < ApplicationController
  #include ActionController::HttpAuthentication::Basic::ControllerMethods
  #http_basic_authenticate_with email: "admin" , password: "admin"


def index

       tweets = Tweet.all
       @tweets = tweets.map {|tweet| {
           id: tweet.id,
           content: tweet.content,
           user: tweet.user_id,
           like_count: tweet.likes.count,
           retweets: tweet.tweet_id,
           retwitter_from: tweet.user_id
           }}
       render json: @tweets
   end


    def date
      @tweets = Tweet.where("created_at >= ? AND created_at <= ?", params[:date_in], params[:date_out])

      render json: @tweets
    end
end

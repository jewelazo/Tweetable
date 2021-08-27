class TweetsController < ApplicationController
  # GET /tweets
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet_new = Tweet.new
  end

  # GET /tweets/:id
  def show
    @tweet = Tweet.find_by(id: params[:id])
    @tweet_comments = @tweet.comments.order(created_at: :desc)
    # @tweet_comments_new = @tweet_comments.new
    # @tweet_comments_new.user_id = User.first.id
    # @tweet_comments_new.category = 'replied_tweet'
  end
end

class TweetsController < ApplicationController
  # GET /tweets
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet_new = Tweet.new
  end

  # GET	/tweets/:id/edit
  def edit
    # @tweet = Tweet.find_by(id: params[:id])
    @tweet = current_user.tweets.find_by(id: params[:id])
    return not_allowed unless @tweet
  end

  # POST /tweets
  def create
    @tweet_new = Tweet.new(tweet_params)
    @tweet_new.user_id = current_user.id
    if @tweet_new.save
      redirect_to tweets_path
    else
      render :index
    end
  end

  # PATCH	/tweets/:id
  def update
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.update(tweet_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # DELETE /tweets/:id
  def destroy
    # @tweet = Tweet.find_by(id: params[:id])
    @tweet = current_user.tweets.find_by(id: params[:id])
    return not_allowed unless @tweet

    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end

  def not_allowed
    flash[:alert] = 'You are not allow to do that'
    redirect_to tweets_path
  end
end

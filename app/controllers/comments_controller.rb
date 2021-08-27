class CommentsController < ApplicationController
  # GET /tweets/:tweet_id/comments
  def index
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @comments = @tweet.comments.order(created_at: :desc)
    @comment_new = @comments.new
  end

  # GET	/tweets/:tweet_id/comments/:id/edit
  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  # POST /tweets/:tweet_id/comments
  def create
    @comment_new = Comment.new(comment_params)
    @comment_new.user_id = User.first.id
    if @comment_new.save
      redirect_to "/tweets/#{@comment_new.tweet.id}/comments"
    else
      render :index
    end
  end

  # PATCH	/tweets/:tweet_id/comments/:id
  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      redirect_to "/tweets/#{@comment.tweet.id}/comments"
    else
      render :edit
    end
  end

  # DELETE /tweets/:tweet_id/comments/:id
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to "/tweets/#{@comment.tweet.id}/comments"
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :tweet_id)
  end
end

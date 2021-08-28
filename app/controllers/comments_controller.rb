class CommentsController < ApplicationController
  # GET /tweets/:tweet_id/comments
  def index
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @comments = @tweet.comments.order(created_at: :desc)
    @comment_new = @comments.new
  end

  # GET	/tweets/:tweet_id/comments/:id/edit
  def edit
    # @comment = Comment.find_by(id: params[:id])
    @comment = current_user.comments.find_by(id: params[:id])
    return not_allowed unless @comment
  end

  # POST /tweets/:tweet_id/comments
  def create
    @comment_new = Comment.new(comment_params)
    @comment_new.user_id = current_user.id
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
    @comment = current_user.comments.find_by(id: params[:id])
    return not_allowed unless @comment

    # @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to "/tweets/#{@comment.tweet.id}/comments"
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :tweet_id)
  end

  def not_allowed
    flash[:alert] = 'You are not allow to do that'
    redirect_to "/tweets/#{params[:tweet_id]}/comments"
  end
end

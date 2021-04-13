class CommentsController < ApplicationController
  before_action :find_comment, only: %i[destroy]
  http_basic_authenticate_with name: 'user', password: 'secret', only: :destroy

  def create
    @comment = Comment.new(comments_params)
    begin
      @comment.save!
      redirect_article
    rescue ActiveRecord::RecordInvalid
      redirect_article
    end
  end

  def destroy
    @comment.destroy!
    redirect_article
  rescue ActiveRecord::RecordNotDestroyed
    redirect_article
  end

  private

  def comments_params
    comment = params.require(:comment).permit(:commenter, :body, :status).to_h
    comment['article_id'] = params['article_id']
    comment
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def redirect_article
    redirect_back fallback_location: articles_url
  end
end

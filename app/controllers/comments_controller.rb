class CommentsController < ApplicationController
  before_action :find_comment, only: %i[destroy]
  http_basic_authenticate_with name: 'user', password: 'secret', only: :destroy

  def create
    @comment = Comment.new(comments_params)
    @comment.article_id = params[:article_id]
    begin
      @comment.save!
    rescue ActiveRecord::RecordInvalid
    end
    redirect_back fallback_location: articles_url
  end

  def destroy
    @comment.destroy if @comment.article_id.eql? params[:article_id].to_i
    redirect_back fallback_location: articles_url
  end

  private

  def comments_params
    params.require(:comment).permit(:commenter, :body, :status, :article_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end

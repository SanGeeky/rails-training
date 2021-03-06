# frozen_string_literal: true

# comments_controller.rb
class CommentsController < ApplicationController
  before_action :find_comment, only: %i[destroy]
  before_action :authorized

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_article
  end

  def destroy
    @comment.destroy
    redirect_article
  end

  private

  def comment_params
    comment = params.require(:comment).permit(:commenter, :body, :status, :user_id)
    comment.merge(article_id: params[:article_id])
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    not_found if @comment.nil?
  end

  def redirect_article
    redirect_back(fallback_location: articles_url)
  end
end

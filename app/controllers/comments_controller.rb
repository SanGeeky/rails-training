class CommentsController < ApplicationController
  before_action :find_article, only: %i[create]
  before_action :find_comment, only: %i[destroy]

  http_basic_authenticate_with name: 'user', password: 'secret', only: :destroy

  def create
    @comment = @article.comments.create(comments_params)
    redirect_to article_path(@article)
  end

  def destroy
    if @comment.article_id == params[:article_id].to_i
      @comment.destroy
    end
    redirect_back fallback_location: articles_url
  end
  
  private

  def comments_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end

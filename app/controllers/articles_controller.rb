# frozen_string_literal: true

# articles_controller.rb
class ArticlesController < ApplicationController
  before_action :find_article, except: %i[index new create]
  before_action :authorized, except: %i[index show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save ? redirect_to(@article) : render(:new)
  end

  def update
    @article.update(article_params) ? redirect_to(@article) : render(:edit)
  end

  def destroy
    @article.destroy
    redirect_to(root_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def find_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end

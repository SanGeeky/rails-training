class ArticlesController < ApplicationController
  before_action :find_article, except: %i[index new create]

  http_basic_authenticate_with name: 'user', password: 'secret', except: %i[index show]

  def index
    @articles = Article.all
  end

  def show
    @article 
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    begin
      @article.save!
    rescue StandardError => e
      render :new
    else
      redirect_to(article_path(@article))
    end
  end

  def edit
    @article
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def find_article
    begin
      @article = Article.find(params[:id])
    rescue => exception
      not_found
    end
  end
end

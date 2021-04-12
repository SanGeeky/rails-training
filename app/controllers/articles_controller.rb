class ArticlesController < ApplicationController
  before_action :find_article, except: %i[index new create]
  http_basic_authenticate_with name: 'user', password: 'secret', except: %i[index show]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    begin
      @article.save!
    rescue ActiveRecord::RecordInvalid
      puts e.message
      render :new
    end
    redirect_to @article
  end

  def edit; end

  def update
    begin
      @article.update!(article_params)
    rescue ActiveRecord::RecordInvalid
      render :edit
    end
    redirect_to @article
  end

  def destroy
    begin
      @article.destroy!
    rescue ActiveRecord::RecordNotDestroyed
      redirect_back fallback_location: root_path
    end
    redirect_to root_path
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

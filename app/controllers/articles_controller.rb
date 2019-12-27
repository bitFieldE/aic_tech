class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  # before_action

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order(released_at: :desc)

    @articles = @articles.open_to_the_public unless current_user

    unless current_user&.administrator?
      @articles = @articles.visible
    end

    @articles = @articles.page(params[:page]).per(10)
  end

  # index
  def search
    @articles = Article.search(params[:q])
      .page(params[:page]).per(10)
    render "index"
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end

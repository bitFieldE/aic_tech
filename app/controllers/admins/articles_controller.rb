class Admins::ArticlesController < Admins::Base
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order(released_at: :desc)
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

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to [:admins, @article], notice: "ニュースを作成しました" }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to [:admins, @article], notice: "ニュースを編集しました" }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admins_articles_url, notice: "ニュースを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(
        :title,
        :body,
        :released_at,
        :expired_at,
        :user_list_only
      )
    end
end

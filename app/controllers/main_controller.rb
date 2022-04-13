class MainController < ArticlesController
  def index
    @articles = Article.all
  end
end

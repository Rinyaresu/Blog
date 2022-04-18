# frozen_string_literal: true

class MainController < ArticlesController
  def index
    @articles = Article.all
  end
end

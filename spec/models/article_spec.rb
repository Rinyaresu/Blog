# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  # create a test to check that the article is not saved without a title
  it "is not valid without a title" do
    article = Article.new
    article.title = ""
    article.content = "test"
    expect(article).not_to be_valid
  end

  # create a test to check that the article is not saved without a body
  it "is not valid without a content" do
    article = Article.new
    article.title = "test"
    article.content = ""
    expect(article).not_to be_valid
  end
end

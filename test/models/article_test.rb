# frozen_string_literal: true

require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should have a title and content" do
    article = Article.new
    assert_not article.valid?
    assert_equal ["can't be blank"], article.errors[:title]
    assert_equal ["can't be blank"], article.errors[:content]
  end

  test "should have a title and max length of 255" do
    article = Article.new(title: "a" * 256)
    assert_not article.valid?
    assert_equal ["is too long (maximum is 255 characters)"],
                 article.errors[:title]
  end

  test "should broadcast update after update commit" do
    article = articles(:one)
    assert_difference(
      ActionCable.server.broadcast(
        "articles",
        {
          action: "update",
          id: article.id,
          title: article.title,
          content: article.content
        }
      )
    ) { article.update(title: "new title", content: "new content") }
  end

  test "should slug title" do
    article = articles(:one)
    assert_equal "MyString", article.slug
  end

  test "should have rich text content" do
    article = articles(:one)
    assert_equal "In a million stars!", article.content.to_plain_text
  end

  test "should broadcast on show" do
    article = articles(:one)
    assert_difference(
      ActionCable.server.broadcast(
        "articles",
        {
          action: "show",
          id: article.id,
          title: article.title,
          content: article.content
        }
      )
    ) { article.save }
  end
end

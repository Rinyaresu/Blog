# frozen_string_literal: true

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup { @article = articles(:one) }

  # Have to be logged in

  test "should get index" do
    get main_index_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    sign_in users(:one)
    assert_difference("Article.count") do
      post articles_url,
           params: {
             article: {
               content: @article.content,
               title: @article.title
             }
           }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    sign_in users(:one)
    patch article_url(@article),
          params: {
            article: {
              content: @article.content,
              title: @article.title
            }
          }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal @article.title, "MyString"
  end

  test "should destroy article" do
    sign_in users(:one)
    assert_difference("Article.count", -1) { delete article_url(@article) }

    assert_redirected_to root_url
  end

  # If not logged in

  test "should not get new" do
    get new_article_url
    assert_redirected_to "/users/sign_in"
  end

  test "should not get edit" do
    get edit_article_url(@article)
    assert_redirected_to "/users/sign_in"
  end

  test "should not create article" do
    assert_difference("Article.count", 0) do
      post articles_url,
           params: {
             article: {
               content: @article.content,
               title: @article.title
             }
           }
    end

    assert_redirected_to "/users/sign_in"
  end

  test "should not update article" do
    patch article_url(@article),
          params: {
            article: {
              content: @article.content,
              title: @article.title
            }
          }
    assert_redirected_to "/users/sign_in"
  end

  test "should not destroy article" do
    assert_difference("Article.count", 0) { delete article_url(@article) }

    assert_redirected_to "/users/sign_in"
  end

  test "should route to index" do
    assert_routing "/main/index", controller: "main", action: "index"
  end

  test "should route to new" do
    assert_routing "/articles/new", controller: "articles", action: "new"
  end

  test "should route to show" do
    assert_routing "/articles/1",
                   controller: "articles",
                   action: "show",
                   id: "1"
  end

  test "should route to edit" do
    assert_routing "/articles/1/edit",
                   controller: "articles",
                   action: "edit",
                   id: "1"
  end

  test "should route to create" do
    assert_routing(
      { method: "post", path: "/articles" },
      controller: "articles",
      action: "create"
    )
  end

  test "should route to update" do
    assert_routing(
      { method: "patch", path: "/articles/1" },
      controller: "articles",
      action: "update",
      id: "1"
    )
  end

  test "should route to destroy" do
    assert_routing(
      { method: "delete", path: "/articles/1" },
      controller: "articles",
      action: "destroy",
      id: "1"
    )
  end
end

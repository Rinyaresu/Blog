require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @article = articles(:one)
  end

  # have to be logged in

  test "should get index" do
      get main_index_url
      assert_response :success
    end

  test "should get new" do
    get new_article_url
    assert_response :found
  end

  test "should create article" do
    sign_in users(:one)
    assert_difference("Article.count") do
      post articles_url, params: { article: { content: @article.content, title: @article.title } }
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
      params: { article: { content: @article.content, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    sign_in users(:one)
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

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
      post articles_url, params: { article: { content: @article.content, title: @article.title } }
    end

    assert_redirected_to "/users/sign_in"
  end

  test "should not update article" do
    patch article_url(@article),
      params: { article: { content: @article.content, title: @article.title } }
    assert_redirected_to "/users/sign_in"
  end

  test "should not destroy article" do
    assert_difference("Article.count", 0) do
      delete article_url(@article)
    end

    assert_redirected_to "/users/sign_in"
  end
end

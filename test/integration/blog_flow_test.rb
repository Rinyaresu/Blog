# frozen_string_literal: true

require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "can create an article" do
    sign_in users(:one)
    get new_article_path
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "Test Title", content: "Test Body" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_match "Test Title", response.body
  end

  test "can edit an article" do
    sign_in users(:one)
    get edit_article_path(articles(:one))
    assert_response :success
    assert_difference "Article.count", 0 do
      patch article_path(articles(:one)),
params: { article: { title: "Test Title", content: "Test Body" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_match "Test Title", response.body
  end

  test "can destroy an article" do
    sign_in users(:one)
    assert_difference "Article.count", -1 do
      delete article_path(articles(:one))
    end
    assert_response :redirect
    follow_redirect!
    assert_match "Article was successfully destroyed", response.body
  end

  test "can not create an article until logged in" do
    get new_article_path
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing.", response.body
  end

  test "can not edit an article until logged in" do
    get edit_article_path(articles(:one))
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing.", response.body
  end

  test "can not destroy an article until logged in" do
    assert_difference "Article.count", 0 do
      delete article_path(articles(:one))
    end
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing.", response.body
  end
end

# frozen_string_literal: true

require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup { @article = articles(:one) }

  test "visiting the index" do
    visit main_index_path
    assert_selector "h1", text: "Recent"
  end

  test "should create article" do
    sign_in users(:one)
    visit main_index_path
    click_on(class: "navbar-toggler")
    click_on "New article"

    fill_in "Title", with: @article.title
    fill_in_rich_text_area "Content", with: @article.content
    click_on "Create Article"

    assert_text "Article was successfully created"
    click_on "Back"
  end

  test "should update Article" do
    sign_in users(:one)
    visit article_url(@article)
    click_on "Edit this article", match: :first

    fill_in "Title", with: @article.title
    fill_in_rich_text_area "Content", with: @article.content
    click_on "Update Article"

    assert_text "Article was successfully updated"
    click_on "Back"
  end

  test "should destroy Article" do
    sign_in users(:one)
    visit article_url(@article)
    click_on "Destroy this article", match: :first
    page.driver.browser.switch_to.alert.accept
    assert_text "Article was successfully destroyed"
  end

  test "should not create article without title" do
    sign_in users(:one)
    visit new_article_path
    click_on "Create Article"
    assert_text "Title can't be blank"
  end

  test "should not create article without content" do
    sign_in users(:one)
    visit new_article_path
    fill_in "Title", with: @article.title
    click_on "Create Article"
    assert_text "Content can't be blank"
  end

  test "should not update article without title" do
    sign_in users(:one)
    visit edit_article_path(@article)
    fill_in "Title", with: ""
    click_on "Update Article"
    assert_text "Title can't be blank"
  end

  test "should not update article without content" do
    sign_in users(:one)
    visit edit_article_path(@article)
    fill_in_rich_text_area "Content", with: ""
    click_on "Update Article"
    assert_text "Content can't be blank"
  end

  test "should not create article without login" do
    visit new_article_path
    assert_text "You need to sign in or sign up before continuing."
  end

  test "should not update article without login" do
    visit edit_article_path(@article)
    assert_text "You need to sign in or sign up before continuing."
  end

  test "should have a button to about page" do
    visit main_index_path
    click_on(class: "navbar-toggler")
    click_on "About"
    assert_text "About"
  end

  test "should have a button to main page" do
    visit about_index_path
    click_on "Kaique's Blog"
    assert_text "Recent"
  end

  test "should have linkedin button" do
    visit about_index_path
    assert_selector "a[href='https://www.linkedin.com/in/kaique-linhares-25a840208/']"
  end

  test "should have github button" do
    visit about_index_path
    assert_selector "a[href='https://github.com/rinyaresu']"
  end

  test "should have twitter button" do
    visit about_index_path
    assert_selector "a[href='https://twitter.com/rinyaresu']"
  end

  test "should have email button" do
    visit about_index_path
    assert_selector "a[href='mailto:kaiquelinhares07@gmail.com']"
  end
end

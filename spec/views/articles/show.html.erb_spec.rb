require "rails_helper"


RSpec.describe "articles/show", type: :view do
  @login_user
  before(:each) do
    @article = assign(:article, Article.create!(
      title: "Title",
      content: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
  end
end

require "rails_helper"

RSpec.describe "main/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(
        title: "MyString",
        content: "MyText"),
      Article.create!(
        title: "MyTitle",
        content: "MyText")
    ])
  end

  it "renders a list of articles" do
    render
  end
end

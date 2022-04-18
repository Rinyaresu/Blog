# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  # create a test to check that the article is not saved without a title
  it "is not valid without a title" do
    article = Article.new
    expect(article).not_to be_valid
  end
end

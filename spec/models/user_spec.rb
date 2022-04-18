# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  # check if the model is valid
  it "is valid with valid attributes" do
    user = User.new(username: "John", email: "user@user.com", password: "password")
    expect(user).to be_valid
  end
end

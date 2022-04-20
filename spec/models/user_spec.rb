# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  # check if the model is valid
  it "is valid with valid attributes" do
    user = User.new(username: "John", email: "user@user.com", password: "password")
    expect(user).to be_valid
  end

  # check if the model is invalid
  it "is invalid without a username" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end

# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user should have username" do
    user = User.new
    assert_not user.valid?
    assert_equal ["can't be blank"], user.errors[:username]
  end

  test "user should have a unique username" do
    user = User.new(username: "test", email: "test@test.com", password: "password")
    assert user.valid?
    user.save
    user2 = User.new(username: "test", email: "test2@test.com", password: "password")
    assert_not user2.valid?
  end

  test "user should have a email" do
    user = User.new(username: "test", email: "", password: "password")
    assert_not user.valid?
    assert_equal ["can't be blank"], user.errors[:email]
  end

  test "user should have a password" do
    user = User.new(username: "test", email: "teste@teste.com", password: "")
    assert_not user.valid?
    assert_equal ["can't be blank"], user.errors[:password]
  end

  test "user should have a password with at least 6 characters" do
    user = User.new(username: "test", email: "teste@teste.com", password: "pass")
    assert_not user.valid?
    assert_equal ["is too short (minimum is 6 characters)"], user.errors[:password]
  end

  test "user should have a unique email" do
    user = User.new(username: "test", email: "teste@teste.com", password: "password")
    user.save
    user2 = User.new(username: "test2", email: "teste@teste.com", password: "password")
    assert_not user2.valid?
  end

  test "user should have a valid email" do
    user = User.new(username: "test", email: "teste.com", password: "password")
    assert_not user.valid?
    assert_equal ["is invalid"], user.errors[:email]
  end
end

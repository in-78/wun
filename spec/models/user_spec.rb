require 'spec_helper'

describe User do

  let(:attrs) do
    {
      name: "Test User",
      email: "example@foo.bar",
      password: "123456",
      password_confirmation: "123456"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(attrs)
  end

  it "should require an email address" do
    no_email_user = User.new(attrs.merge(email: ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(attrs.merge(email: address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(attrs.merge(email: address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(attrs)
    user_with_duplicate_email = User.new(attrs)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = attrs[:email].upcase
    User.create!(attrs.merge(email: upcased_email))
    user_with_duplicate_email = User.new(attrs)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    let(:simple_user) { User.new(attrs) }

    it "should have a password attribute" do
      simple_user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      simple_user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(attrs.merge(password: "", password_confirmation: "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(attrs.merge(password_confirmation: "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = attrs.merge(password: short, password_confirmation: short)
      User.new(hash).should_not be_valid
    end

    it "should reject too long passwords" do
      long = "a" * 31
      hash = attrs.merge(password: long, password_confirmation: long)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    let(:simple_user) { User.create!(attrs) }

    it "should have an encrypted password attribute" do
      simple_user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      simple_user.encrypted_password.should_not be_blank
    end

  end

end
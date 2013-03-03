require 'spec_helper'

describe List do

  let(:attrs) { { title: "foo bar list" } }
  let(:simple_user) { FactoryGirl.create :user }
  let(:todo_list)   { simple_user.lists.create(attrs) }

  it "should create a new instance given valid attributes" do
    simple_user.lists.create!(attrs)
  end

  describe "user associations" do

    it "should have a user attribute" do
      todo_list.should respond_to(:user)
    end

    it "should have the right associated user" do
      todo_list.user_id.should == simple_user.id
      todo_list.user.should == simple_user
    end
  end

  describe "validations" do

    it "should require a user id" do
      List.new(attrs).should_not be_valid
    end

    it "should require nonblank title" do
      simple_user.lists.build(title: "  ").should_not be_valid
    end

    it "should reject long title" do
      simple_user.lists.build(title: "a" * 201).should_not be_valid
    end

    it "should have the position" do
      todo_list.position.should_not be_blank
    end

    it "#is_usual?" do
    	todo_list.is_usual?.should be_true
    end

    it "#is_marked?" do
    	todo_list.is_marked?.should be_false
    end

    it "#is_week?" do
    	todo_list.is_week?.should be_false
    end

    it "should be marked" do
    	marked_list = simple_user.lists.new(attrs)
    	marked_list.marked
    	marked_list.save!
    	marked_list.is_marked?.should be_true
    end

    it "should be weekly" do
    	weekly_list = simple_user.lists.new(attrs)
    	weekly_list.week
    	weekly_list.save!
    	weekly_list.is_week?.should be_true
    end
  end

end
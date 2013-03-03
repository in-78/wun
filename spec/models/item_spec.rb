require 'spec_helper'

describe Item do

  let(:attrs) { { name: "foo bar item", description: "some description", date_due: DateTime.now } }
  let(:simple_user) { FactoryGirl.create :user }
  let(:todo_list)   { FactoryGirl.create(:list, user: simple_user) }

  it "should create a new instance given valid attributes" do
    todo_list.items.create!(attrs)
  end

  describe "list associations" do

    let(:todo_item) { todo_list.items.create(attrs) }

    it "should have a list attribute" do
      todo_item.should respond_to(:list)
    end

    it "should have the right associated list" do
      todo_item.list_id.should == todo_list.id
      todo_item.list.should == todo_list
    end
  end

  describe "user methods validations" do

    let(:todo_item) { todo_list.items.create(attrs) }

		it "should work user helper" do
      todo_item.user == simple_user
    end

    it "should work a user_id helper" do
      todo_item.user_id == simple_user.id
    end
	end

  describe "validations" do

    it "should require a list id" do
      Item.new(attrs).should_not be_valid
    end

    it "should require nonblank name" do
      todo_list.items.build( name: "  ").should_not be_valid
    end

	  it "should reject duplicate names" do
	    todo_list.items.create!(attrs)
	    item_with_duplicate_name = todo_list.items.new(attrs)
	    item_with_duplicate_name.should_not be_valid
	  end

	  it "should reject names identical up to case" do
	    upcased_name = attrs[:name].upcase
	    todo_list.items.create!(attrs.merge(name: upcased_name))
	    item_with_duplicate_name = todo_list.items.new(attrs)
	    item_with_duplicate_name.should_not be_valid
	  end
  end

  describe "scope validations" do

    let(:todo_item) { todo_list.items.create(attrs) }

		it "includes items with deadline date in current week" do
			Item.week.should include(todo_item)
    end

    it "includes items with lists who owned by the user" do
      Item.by_user(simple_user).should include(todo_item)
    end
	end
end
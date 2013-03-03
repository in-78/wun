require 'spec_helper'

describe ItemsController do
	render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, id: 1
      response.should redirect_to(root_path)
    end
  end

  describe "POST 'create'" do

    login_user

    describe "failure" do

    	let(:attrs) { { name: "" } }

      it "should not create a item" do
        lambda do
          post :create, :item => attrs
        end.should_not change(Item, :count)
      end

      it "should redirect to the items page" do
        post :create, :item => attrs
        response.should redirect_to(lists_path)
      end
    end

    describe "success" do

    	let(:attrs) { { name: "foo bar item" } }

      it "should create a item" do
        lambda do
          post :create, :item => attrs
        end.should change(Item, :count).by(1)
      end

      it "should redirect to the items page" do
        post :create, :item => attrs
        response.should redirect_to(lists_path)
      end

      it "should have a flash message" do
        post :create, :item => attrs
        flash[:success].should =~ /item created/i
      end
    end
  end

  describe "DELETE 'destroy'" do

		let(:attrs) { { name: "foo bar item" } }

    describe "for an unauthorized user" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        test_sign_in(wrong_user)
        @list = FactoryGirl.create(:list, user: @user)
        @item = @list.items.create(attrs)
      end   

      it "should deny access" do
        delete :destroy, id: @item
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      login_user

      before(:each) do
        @list = FactoryGirl.create(:list, user: @user)
        @item = @list.items.create(attrs)
      end

      it "should destroy the micropost" do
        lambda do
          delete :destroy, id: @item
        end.should change(Item, :count).by(-1)
      end
    end
  end
end
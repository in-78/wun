require 'spec_helper'

describe ListsController do
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

    	let(:attrs) { { title: "" } }

      it "should not create a list" do
        lambda do
          post :create, :list => attrs
        end.should_not change(List, :count)
      end

      it "should redirect to the lists page" do
        post :create, :list => attrs
        response.should redirect_to(lists_path)
      end
    end

    describe "success" do

    	let(:attrs) { { title: "foo bar list" } }

      it "should create a list" do
        lambda do
          post :create, :list => attrs
        end.should change(List, :count).by(1)
      end

      it "should redirect to the lists page" do
        post :create, :list => attrs
        response.should redirect_to(lists_path)
      end

      it "should have a flash message" do
        post :create, :list => attrs
        flash[:success].should =~ /list created/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
        test_sign_in(wrong_user)
        @list = FactoryGirl.create(:list, :user => @user)
      end   

      it "should deny access" do
        delete :destroy, id: @list
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @list = FactoryGirl.create(:list, :user => @user)
      end

      it "should destroy the micropost" do
        lambda do
          delete :destroy, id: @list
        end.should change(List, :count).by(-1)
      end
    end
  end
end
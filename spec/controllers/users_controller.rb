require 'rails_helper'

describe UsersController do
  describe "GET index" do
    it "show all users" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "GET new" do
    it "set @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "create a user " do
        expect(User.count).to eq(1)
      end
      it "redirects to users page"
      it "set flash success"
    end
    
    context "with invalid input" do
      it ""
      it ""
      it ""
    end
  end
end
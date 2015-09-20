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
      it "redirects to users page" do
        expect(response).to redirect_to home_path
      end
      it "set flash success" do
        expect(flash[:success]).to eq("You are registered.")
      end
    end
    
    context "with invalid input" do
      
      before do
        post :create, user: { password: 'password', full_name: 'Kevin Chang' }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      
      it "set @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "render new template" do
        expect(response).to render_template :new 
      end
    end
  end
end
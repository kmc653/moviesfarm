require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "render new template for authenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do

    context "with valid credentials" do

      let(:kevin) { Fabricate(:user) }

      before do
        post :create, email: kevin.email, password: kevin.password
      end

      it "puts login user in session" do
        expect(session[:user_id]).to eq(kevin.id)
      end
      
      it "redirects to home page" do
        expect(response).to redirect_to home_path
      end
      
      it "sets notice" do
        expect(flash[:success]).to eq("Welcome, You logged in!")
      end
    end

    context "with invalid credentials" do
      
      let(:kevin) { Fabricate(:user) }

      before do
        post :create, email: kevin.email, password: kevin.password + 'aaa'
      end

      it "doesn't put login user in session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end
      it "show error message" do
        expect(flash[:error]).to eq("Invalid email or password.")
      end
    end

  end

  describe "GET destroy" do

    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clear session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to login page" do
      expect(response).to redirect_to login_path
    end

    it "show logout message" do
      expect(flash[:success]).to eq("You're logged out.")
    end

  end
end
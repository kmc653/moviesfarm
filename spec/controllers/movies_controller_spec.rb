require 'rails_helper'

describe MoviesController do
  describe "GET new" do
    it "sets the @movie to a new video" do
      get :new
      expect(assigns(:movie)).to be_instance_of Movie
      expect(assigns(:movie)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, movie: Fabricate.attributes_for(:movie)
      end
      
      it "redirects to home page" do
        expect(response).to redirect_to home_path
      end
      
      it "create a movie" do
        expect(Movie.count).to eq(1)
      end

      it "sets flash success message" do
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      before do
        post :create, movie: { title: "Super Man", year: "2004" }
      end

      it "does not create a movie" do
        expect(Movie.count).to eq(0)
      end
      
      it "render :new template" do
        expect(response).to render_template :new
      end
      
      it "sets @movie variable" do
        expect(assigns(:movie)).to be_present
      end
      
      it "set flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
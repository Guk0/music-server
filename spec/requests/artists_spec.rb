require 'rails_helper'

RSpec.describe "Artists", type: :request do
  describe "GET /artists" do
    before do
      @artist = FactoryBot.create(:artist)
    end

    it "returns http success" do
      get artists_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /artists/:id" do
    before do
      @artist = FactoryBot.create(:artist)
    end

    it "returns http success" do      
      get artist_path(@artist.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /artists" do
    context "with valid parameters" do        
      it "creates a new artist" do
        artist_params = FactoryBot.attributes_for(:artist)
        expect {
          post artists_path, params: { artist: artist_params }
        }.to change(Artist, :count).by(1)
      end
    end

    context "with invalid parameters" do        
      it "does not create a new artist" do
        artist_params = FactoryBot.attributes_for(:artist, :invalid)          
        expect {
          post artists_path, params: { artist: artist_params }
        }.to change(Artist, :count).by(0)
      end
    end
  end

  describe "DELETE /artists/:id" do
    before do
      @artist = FactoryBot.create(:artist)
    end

    it "deletes a artist" do
      expect {
        delete artist_path(@artist.id)
      }.to change(Artist, :count).by(-1)
    end
  end

  describe "PATCH /artists/:id" do
    before do
      @artist = FactoryBot.create(:artist)
    end

    it "updates a artist" do
      artist_params = FactoryBot.attributes_for(:artist, name: "new name")
      patch artist_path(@artist.id), params: { artist: artist_params }

      expect(@artist.reload.name).to eq("new name")
    end
  end
end

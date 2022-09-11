require 'rails_helper'

RSpec.describe "Tracks", type: :request do
  describe "GET /tracks" do
    before do
      @track = FactoryBot.create(:track)
    end

    it "returns http success" do
      get tracks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /tracks/:id" do
    before do
      @track = FactoryBot.create(:track)
    end

    it "returns http success" do      
      get track_path(@track.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /tracks" do
    context "with valid parameters" do        
      it "creates a new track" do
        track_params = FactoryBot.attributes_for(:track, artist_id: create(:artist).id, album_id: create(:album).id)
        expect {
          post tracks_path, params: { track: track_params }
        }.to change(Track, :count).by(1)
      end
    end

    context "with invalid parameters" do        
      it "does not create a new track" do
        track_params = FactoryBot.attributes_for(:track, :invalid, artist_id: create(:artist).id, album_id: create(:album).id)
        expect {
          post tracks_path, params: { track: track_params }
        }.to change(Track, :count).by(0)
      end
    end
  end

  describe "DELETE /tracks/:id" do
    before do
      @track = FactoryBot.create(:track)
    end

    it "deletes a track" do
      expect {
        delete track_path(@track.id)
      }.to change(Track, :count).by(-1)
    end
  end

  describe "PATCH /tracks/:id" do
    before do
      @track = FactoryBot.create(:track)
    end

    it "updates a track" do
      track_params = FactoryBot.attributes_for(:track, title: "new title")
      patch track_path(@track.id), params: { track: track_params }

      expect(@track.reload.title).to eq("new title")
    end
  end
end

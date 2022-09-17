require 'rails_helper'

RSpec.describe "Albums", type: :request do
  describe "GET /albums" do
    before do
      @album = FactoryBot.create(:album)
    end

    it "returns http success" do
      get albums_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /albums/:id" do
    before do
      @album = FactoryBot.create(:album)
    end

    it "returns http success" do      
      get album_path(@album.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /albums" do
    context "with valid parameters" do        
      it "creates a new album" do
        album_params = FactoryBot.attributes_for(:album, artist_id: create(:artist).id)
        expect {
          post albums_path, params: { album: album_params }
        }.to change(Album, :count).by(1)
      end
    end

    context "with invalid parameters" do        
      it "does not create a new album" do
        album_params = FactoryBot.attributes_for(:album, :invalid)          
        expect {
          post albums_path, params: { album: album_params }
        }.to change(Album, :count).by(0)
      end
    end
  end

  describe "DELETE /albums/:id" do
    before do
      @album = FactoryBot.create(:album)
    end

    it "deletes a album" do
      expect {
        delete album_path(@album.id)
      }.to change(Album, :count).by(-1)
    end
  end

  describe "PATCH /albums/:id" do
    before do
      @album = FactoryBot.create(:album)
      @track = FactoryBot.create(:track, album: @album, artist: @album.artist)
    end

    it "updates a album" do
      album_params = FactoryBot.attributes_for(:album, title: "new title")
      patch album_path(@album.id), params: { album: album_params }

      expect(@album.reload.title).to eq("new title")

      expect(@track.reload.album_name).to eq("new title")
    end
  end
end

require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  describe "GET /playlists" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "returns http success" do
      get playlists_path(owner_id: @playlist.owner.id, owner_type: "user", list_type: "default")
      expect(response).to have_http_status(:success)
    end

    it "raise RecordNotFound exception" do
      expect {
        get playlists_path(owner_id: nil, owner_type: "user", list_type: "default")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raise KeyError exception" do
      expect {
        get playlists_path(owner_id: 5, owner_type: nil, list_type: "default")
      }.to raise_error(KeyError)
    end
  end

  describe "GET /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "returns http success" do      
      get playlist_path(owner_id: @playlist.owner.id, owner_type: "user", id: @playlist.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /playlists" do
    context "posts a playlist" do
      before do
        @playlist = FactoryBot.create(:playlist)
      end

      context "with valid parameters" do        
        it "creates a new playlist" do
          playlist_params = FactoryBot.attributes_for(:playlist)
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: @playlist.owner.id }
          }.to change(Playlist, :count).by(1)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new playlist" do
          playlist_params = FactoryBot.attributes_for(:playlist)          
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: nil }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "DELETE /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "deletes a playlist" do
      expect {
        delete playlist_path(id: @playlist.id, owner_type: "user", owner_id: @playlist.owner.id)
      }.to change(Playlist, :count).by(-1)
    end
  end

  describe "PATCH /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "updates a playlist" do
      playlist_params = FactoryBot.attributes_for(:playlist, title: "new title")
      patch playlist_path(@playlist.id), params: { playlist: playlist_params, owner_type: "user", owner_id: @playlist.owner.id }

      expect(@playlist.reload.title).to eq("new title")
    end
  end
end

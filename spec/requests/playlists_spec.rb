require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  describe "GET /playlists" do
    before do
      @user = FactoryBot.create(:user)
      @playlist = FactoryBot.create(:my_playlist, owner: @user)
    end

    it "returns http success" do
      get playlists_path(owner_id: @user.id, owner_type: "user", list_type: "default")
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
      @user = FactoryBot.create(:user)
      @playlist = FactoryBot.create(:my_playlist, owner: @user)
    end

    it "returns http success" do      
      get playlist_path(owner_id: @user.id, owner_type: "user", id: @playlist.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /playlists" do
    context "posts a playlist" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:my_playlist, owner: @user)
      end

      context "with valid parameters" do        
        it "creates a new playlist" do
          playlist_params = FactoryBot.attributes_for(:my_playlist)
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: @user.id }
          }.to change(Playlist, :count).by(1)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new playlist" do
          playlist_params = FactoryBot.attributes_for(:my_playlist)          
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: nil }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "DELETE /playlists/:id" do
    context "deletes a playlist" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:my_playlist, owner: @user)
      end

      it "deletes a playlist" do
        expect {
          delete playlist_path(id: @playlist.id, owner_type: "user", owner_id: @user.id)
        }.to change(Playlist, :count).by(-1)
      end
    end
  end

  describe "PATCH /playlists/:id" do
    context "updates a playlist" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:my_playlist, owner: @user)
      end

      it "updates a playlist" do
        playlist_params = FactoryBot.attributes_for(:my_playlist, title: "new title")
        patch playlist_path(@playlist.id), params: { playlist: playlist_params, owner_type: "user", owner_id: @user.id }

        expect(@playlist.reload.title).to eq("new title")
      end
    end
  end
end

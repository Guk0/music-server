require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  describe "GET /playlists" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "returns http success" do
      get playlists_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
    end

    it "returns http success" do      
      get playlist_path(id: @playlist.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /playlists" do
    context "posts a playlist" do
      before do
        @playlist = FactoryBot.create(:playlist)
        @user = @playlist.owner
      end

      context "with valid parameters" do        
        it "creates a new playlist" do
          playlist_params = FactoryBot.attributes_for(:playlist)
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: @playlist.owner.id, user_id: @user.id }
          }.to change(Playlist, :count).by(1)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new playlist" do
          playlist_params = FactoryBot.attributes_for(:playlist)          
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: "user", owner_id: nil, user_id: @user.id }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "raise KeyError exception" do
          playlist_params = FactoryBot.attributes_for(:playlist)          
          expect {
            post playlists_path, params: { playlist: playlist_params, owner_type: nil, owner_id: @playlist.owner.id, user_id: @user.id }
          }.to raise_error(KeyError)
        end  
      end
    end
  end

  describe "DELETE /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
      @user = @playlist.owner
    end

    it "deletes a playlist" do
      expect {
        delete playlist_path(id: @playlist.id, owner_type: "user", owner_id: @playlist.owner.id, user_id: @user.id)
      }.to change(Playlist, :count).by(-1)
    end
  end

  describe "PATCH /playlists/:id" do
    before do
      @playlist = FactoryBot.create(:playlist)
      @user = @playlist.owner
    end

    it "updates a playlist" do
      playlist_params = FactoryBot.attributes_for(:playlist, title: "new title")
      patch playlist_path(@playlist.id), params: { playlist: playlist_params, owner_type: "user", owner_id: @playlist.owner.id, user_id: @user.id }

      expect(@playlist.reload.title).to eq("new title")
    end
  end
end

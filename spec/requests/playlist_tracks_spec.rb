require 'rails_helper'

RSpec.describe "PlaylistTracks", type: :request do
  describe "POST /playlist_tracks" do

    context "with group playlist" do
      before do
        group = FactoryBot.create(:group_with_users, users_count: 1)
        @user = group.users.last
        @playlist = FactoryBot.create(:playlist, owner: group)
        @track = FactoryBot.create(:track)
      end

      context "with valid parameters" do        
        it "creates a new playlist_track" do
          params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
          expect {
            post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(1)
        end
      end

      context "without track_id" do        
        it "does not creates a new playlist_track" do
          params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: nil, user_id: @user.id)
          expect {
            post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(0)
        end
      end 

      context "with invalid user_id" do
        it "does not creates a new playlist_track" do
          invalid_user = create(:user)
          params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: invalid_user.id)
          expect {
            post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: invalid_user.id }
          }.to change(PlaylistTrack, :count).by(0)
          
          expect(response).to have_http_status(403)
        end
      end 
    end


    context "with user playlist" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:playlist, owner: @user)
        @track = FactoryBot.create(:track)
      end

      context "with valid parameters" do        
        it "creates a new playlist_track" do
          params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
          expect {
            post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(1)
        end
      end

      context "without track_id" do        
        it "does not creates a new playlist_track" do
          params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: nil, user_id: @user.id)
          expect {
            post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(0)
        end
      end 
    end

    context "with more than 100 playlist_tracks" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:playlist, owner: @user)
        @track = FactoryBot.create(:track)
        create_list(:playlist_track, 100, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
      end

      it "creates a new playlist_track and deletes first of playlist_tracks" do
        params = FactoryBot.attributes_for(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
        first_playlist_track = @playlist.playlist_tracks.first
        
        expect {
          post playlist_tracks_path, params: { playlist_track: params }, headers: { Authorization: @user.id }
        }.to change(PlaylistTrack, :count).by(0)
        
        expect(first_playlist_track).not_to eq(@playlist.playlist_tracks.first)
        expect(@playlist.playlist_tracks.size).to eq(100)
      end
    end
  end

  describe "DELETE /playlist_tracks/:id" do
    context "with group playlist" do
      before do
        group = FactoryBot.create(:group_with_users, users_count: 1)
        @user = group.users.last
        @playlist = FactoryBot.create(:playlist, owner: group)
        @track = FactoryBot.create(:track)
        @playlist_track = FactoryBot.create(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
      end

      context "with valid parameters" do
        it "deletes a playlist_track" do
          expect {
            delete playlist_track_path(@playlist_track.id), params: { playlist_id: @playlist.id }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(-1)
        end
      end

      context "with invalid user_id" do
        it "deletes a playlist_track" do
          expect {
            delete playlist_track_path(@playlist_track.id), params: { playlist_id: @playlist.id }, headers: { Authorization: create(:user).id }
          }.to change(PlaylistTrack, :count).by(0)

          expect(response).to have_http_status(403)
        end
      end
    end

    context "with user playlist" do
      before do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:playlist, owner: @user)
        @track = FactoryBot.create(:track)
        @playlist_track = FactoryBot.create(:playlist_track, playlist_id: @playlist.id, track_id: @track.id, user_id: @user.id)
      end

      context "with valid parameters" do
        it "deletes a playlist_track" do
          expect {
            delete playlist_track_path(@playlist_track.id), params: { playlist_id: @playlist.id }, headers: { Authorization: @user.id }
          }.to change(PlaylistTrack, :count).by(-1)
        end
      end

      context "with invalid user_id" do
        it "deletes a playlist_track" do
          expect {
            delete playlist_track_path(@playlist_track.id), params: { playlist_id: @playlist.id }, headers: { Authorization: create(:user).id }
          }.to change(PlaylistTrack, :count).by(0)

          expect(response).to have_http_status(403)
        end
      end
    end
  end
end

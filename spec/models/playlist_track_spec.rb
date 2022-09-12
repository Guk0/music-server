require 'rails_helper'

RSpec.describe PlaylistTrack, type: :model do
  let(:mock_playlist_track) { build(:playlist_track, track: create(:track), user: create(:user), playlist: create(:playlist)) }

  subject { mock_playlist_track }

  it "has a valid user_id" do
    is_expected.to be_valid
    mock_playlist_track.user_id = ""
    is_expected.to_not be_valid
  end

  it "has a valid track_id" do
    is_expected.to be_valid

    mock_playlist_track.track_id = ""
    is_expected.to_not be_valid
  end

  it "has a valid playlist_id" do
    is_expected.to be_valid

    mock_playlist_track.playlist_id = ""
    is_expected.to_not be_valid
  end
end

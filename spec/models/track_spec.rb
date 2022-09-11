require 'rails_helper'

RSpec.describe Track, type: :model do
  let(:mock_track) { build(:track, artist: create(:artist), album: create(:album)) }

  subject { mock_track }

  it "has a valid title" do
    is_expected.to be_valid
    mock_track.title = ""
    is_expected.to_not be_valid
  end

  it "has a valid artist_name" do
    is_expected.to be_valid
    mock_track.artist_name = ""
    is_expected.to_not be_valid
  end

  it "has a valid album_name" do
    is_expected.to be_valid
    mock_track.album_name = ""
    is_expected.to_not be_valid
  end
end

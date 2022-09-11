require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:mock_album) { build(:album, artist: create(:artist)) }

  subject { mock_album }

  it "has a valid title" do
    is_expected.to be_valid
    mock_album.title = ""
    is_expected.to_not be_valid
  end

  it "has a valid artist_id" do
    is_expected.to be_valid
    mock_album.artist_id = ""
    is_expected.to_not be_valid
  end
end

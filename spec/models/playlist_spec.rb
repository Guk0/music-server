require 'rails_helper'

RSpec.describe Playlist, type: :model do
  let(:mock_playlist) { build(:playlist, owner: create(:user)) }

  subject { mock_playlist }

  it "has a valid owner_type" do
    is_expected.to be_valid
    mock_playlist.owner_type = ""
    is_expected.to_not be_valid
  end

  it "has a valid owner_id" do
    is_expected.to be_valid

    mock_playlist.owner_id = ""
    is_expected.to_not be_valid
  end
end

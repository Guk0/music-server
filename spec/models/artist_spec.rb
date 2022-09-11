require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:mock_artist) { build(:artist) }

  subject { mock_artist }

  it "has a valid name" do
    is_expected.to be_valid
    mock_artist.name = ""
    is_expected.to_not be_valid
  end
end

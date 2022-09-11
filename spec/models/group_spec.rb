require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:mock_group) { create(:group_with_users) }
  subject { create(:group_with_users) }

  context "associations" do    
    it "has a valid number of users" do      
      expect(mock_group.users.size).to eq(5)
      expect(create(:group_with_users, users_count: 1).users.size).to eq(1)
    end

    it "has a valid number of user_groups" do
      expect(mock_group.user_groups.size).to eq(5)
      expect(create(:group_with_users, users_count: 1).user_groups.size).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe "UserGroups", type: :request do
  describe "POST /user_groups" do
    context "posts a user_group" do
      before do
        @group = FactoryBot.create(:group)
        @user = FactoryBot.create(:user)
      end

      context "with valid parameters" do        
        it "creates a new user_group" do
          expect {
            post user_groups_path, params: { group_id: @group.id, user_id: @user.id }
          }.to change(UserGroup, :count).by(1)

          expect(Group.last.users.last).to eq(@user)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new group" do
          expect {
            post user_groups_path, params: { group_id: @group.id, user_id: nil }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "DELETE /user_groups/:id" do
    before do
      @group = FactoryBot.create(:group_with_users, users_count: 1)
    end

    it "deletes a group" do
      expect {
        delete user_group_path(@group.user_groups.last.id, group_id: @group.id)
      }.to change(UserGroup, :count).by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    before do      
      @group = FactoryBot.create(:group, owner: create(:user))
    end

    it "returns http success" do
      get groups_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /groups/:id" do
    before do
      @group = FactoryBot.create(:group, owner: create(:user))
    end

    it "returns http success" do      
      get group_path(@group.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /groups" do
    context "posts a group" do
      before do
        @user = FactoryBot.create(:user)
      end

      context "with valid parameters" do        
        it "creates a new group and user_group" do
          group_params = FactoryBot.attributes_for(:group)
          expect {
            post groups_path, params: { group: group_params }, headers: { Authorization: @user.id }
          }.to change(Group, :count).by(1)

          expect(Group.last.users.last).to eq(@user)
          expect(Group.last.owner).to eq(@user)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new group" do
          group_params = FactoryBot.attributes_for(:group, :invalid)          
          expect {
            post groups_path, params: { group: group_params }, headers: { Authorization: @user.id }
          }.to change(Group, :count).by(0)
        end
      end
    end
  end

  describe "DELETE /groups/:id" do
    before do
      @owner = FactoryBot.create(:user)
      @group = FactoryBot.create(:group_with_users, users_count: 1, owner: @owner)      
      @group.users << @owner
    end

    it "deletes a group" do
      expect {
        delete group_path(@group.id), headers: { Authorization: @owner.id }
      }.to change(Group, :count).by(-1)
    end
  end

  describe "PATCH /groups/:id" do
    before do
      @owner = FactoryBot.create(:user)
      @group = FactoryBot.create(:group_with_users, users_count: 1, owner: @owner)      
      @user = @group.users.first
      @group.users << @owner
    end

    it "updates a group" do
      group_params = FactoryBot.attributes_for(:group, name: "new name")
      patch group_path(@group.id), params: { group: group_params }, headers: { Authorization: @owner.id }

      expect(@group.reload.name).to eq("new name")
    end

    it "does not updates a group" do
      # @user is not owner of group
      group_params = FactoryBot.attributes_for(:group, name: "new new name")
      patch group_path(@group.id), params: { group: group_params }

      expect(response).to have_http_status(403)
      expect(@group.reload.name).not_to eq("new new name")
    end
  end
end

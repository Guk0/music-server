require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    before do      
      @group = FactoryBot.create(:group)
    end

    it "returns http success" do
      get groups_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /groups/:id" do
    before do
      @group = FactoryBot.create(:group)
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
            post groups_path, params: { group: group_params, user_id: @user.id }
          }.to change(Group, :count).by(1)

          expect(Group.last.users.last).to eq(@user)
        end
      end

      context "with invalid parameters" do        
        it "does not create a new group" do
          group_params = FactoryBot.attributes_for(:group, :invalid)          
          expect {
            post groups_path, params: { group: group_params, user_id: @user.id }
          }.to change(Group, :count).by(0)
        end
      end
    end
  end

  describe "DELETE /groups/:id" do
    before do
      @group = FactoryBot.create(:group_with_users, users_count: 1)
      @user = @group.users.first
    end

    it "deletes a group" do
      expect {
        delete group_path(@group.id, user_id: @user.id)
      }.to change(Group, :count).by(-1)
    end
  end

  describe "PATCH /groups/:id" do
    before do
      @group = FactoryBot.create(:group_with_users, users_count: 1)
      @user = @group.users.first
    end

    it "updates a group" do
      group_params = FactoryBot.attributes_for(:group, name: "new name")
      patch group_path(@group.id), params: { group: group_params, user_id: @user.id }

      expect(@group.reload.name).to eq("new name")
    end
  end
end

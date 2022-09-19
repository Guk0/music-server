require 'swagger_helper'

RSpec.describe 'user_groups', type: :request do
  path '/user_groups' do
    post 'create user_group' do
      tags 'user_group'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :user_id, in: :query, type: :integer, description: '그룹에 추가할 사용자', required: true
      parameter name: :group_id, in: :query, type: :integer, description: '사용자를 추가할 그룹', required: true
      description 'user_group를 생성합니다. <br> group의 owner만 user_group을 생성할 수 있습니다. <br> 사용자 검증을 위하여 owner_id를 추가로 받습니다.'

      before do
        @group = FactoryBot.create(:group)
        @owner = @group.owner
        @user = FactoryBot.create(:user)
      end
      
      response 201, 'create user_group' do
        let(:user_id) { @user.id }
        let(:Authorization) { @owner.id }
        let(:group_id) { @group.id }

        run_test!
      end
    end
  end

  path '/user_groups/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @group = FactoryBot.create(:group_with_users, users_count: 1)
      @user_group = @group.user_groups.first
      @owner = @group.owner
    end

    delete 'delete user_group' do
      tags 'user_group'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      description 'user_group을 삭제합니다. <br> group의 owner만 user_group을 삭제할 수 있습니다. <br> 사용자 검증을 위하여 owner_id를 추가로 받습니다.'

      response(204, 'successful') do
        let(:id) { @user_group.id }
        let(:Authorization) { @owner.id }

        run_test!
      end
    end
  end
end

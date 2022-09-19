require 'swagger_helper'

RSpec.describe 'groups', type: :request do
  path '/groups' do
    get 'list groups' do
      tags 'group'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'group 리스트를 가져옵니다. 본인이 속한 group외의 group도 볼 수 있습니다.'
      
      response(200, 'successful') do
        run_test!
      end
    end

    post 'create group' do
      tags 'group'
      parameter name: :group, in: :body, schema: { '$ref' => '#/components/schemas/group_object' }
      parameter name: 'user_id', in: :query, type: :integer, description: 'group의 소유자로 등록하기 위해 사용', required: true

      before do
        @user = FactoryBot.create(:user)
      end  

      description 'group를 생성합니다. name은 필수입니다. <br> user_id를 받아 해당 user를 group의 owner로 지정합니다.(추후 auth기능 추가시 변경) <br> 그룹 생성 시 그룹의 playlist(default type)가 생성됩니다.'
      response 200, 'group created' do
        let(:user_id) { @user.id }
        let(:group) { { name: 'group name' } }
        run_test!
      end

      response 422, 'failed' do
        let(:user_id) { @user.id }
        let(:group) { { name: nil } }
        run_test!
      end
    end
  end

  path '/groups/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @user = FactoryBot.create(:user)
      @group = FactoryBot.create(:group, owner: @user)
      @group.users << @user
    end  

    get 'show group' do
      tags 'group'
      description '개별 group을 조회합니다. 본인이 속한 group외의 group도 볼 수 있습니다.'
      response(200, 'successful') do
        let(:id) { @group.id }

        run_test!
      end
    end

    put 'update group' do
      tags 'group'
      description 'group을 수정합니다. group의 owner만 수정할 수 있습니다.'
      parameter name: 'user_id', in: :query, type: :integer, description: '사용자 검증을 위해 사용', required: true
      parameter name: :group, in: :body, schema: { '$ref' => '#/components/schemas/group_object' }

      response(200, 'successful') do
        let(:id) { @group.id }
        let(:user_id) { @user.id }
        let(:group) { { name: 'group name' } }

        run_test!
      end
    end

    delete 'delete group' do
      tags 'group'
      parameter name: 'user_id', in: :query, type: :integer, description: '사용자 검증을 위해 사용', required: true
      description 'group을 삭제합니다. group의 owner만 삭제할 수 있습니다.'
      response(204, 'successful') do
        let(:id) { @group.id }
        let(:user_id) { @user.id }

        run_test!
      end
    end
  end
end

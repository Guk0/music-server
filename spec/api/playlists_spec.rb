require 'swagger_helper'

RSpec.describe 'playlists', type: :request do
  path '/playlists' do
    get 'list playlists' do
      tags 'playlist'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'playlist 리스트를 가져옵니다. my_album(내앨범) 타입의 playlist만 조회합니다. <br> 타인의 playlist를 조회할 수 있습니다.'
      
      response(200, 'successful') do
        run_test!
      end
    end

    post 'create playlist' do
      tags 'playlist'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :playlist, in: :body, schema: { '$ref' => '#/components/schemas/playlist_object' }
      parameter name: :owner_id, in: :query, type: :integer, description: 'user_id or group_id', required: true
      parameter name: :owner_type, in: :query, type: :string, description: 'user or group', required: true

      before do
        @user = FactoryBot.create(:user)
      end
      
      response 200, 'create playlist' do
        let(:Authorization) { @user.id }
        let(:owner_id) { @user.id }
        let(:owner_type) { "user" }
        let(:playlist) { { title: 'playlist title' } }
        
        run_test!
      end
    end
  end

  path '/playlists/my_playlist' do
    get 'get my_playlists' do
      tags 'playlist'
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :page, in: :query, type: :string, description: 'page', example: 1, required: false
      parameter name: :owner_id, in: :query, type: :integer, description: 'user_id or group_id', required: true
      parameter name: :owner_type, in: :query, type: :string, description: 'user or group', required: true      

      description '나 혹은 내가 속한 그룹의 playlist를 조회합니다.'
      
      before do
        @user = FactoryBot.create(:user)
      end

      response(200, 'successful') do
        let(:owner_id) { @user.id }
        let(:owner_type) { "user" }
        let(:Authorization) { @user.id }
        run_test!
      end
    end
  end

  path '/playlists/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    before do
      @playlist = FactoryBot.create(:playlist)
      @user = @playlist.owner
    end

    get 'show playlist' do
      tags 'playlist'
      description '개별 playlist 리스트를 가져옵니다. my_album(내앨범) 타입의 playlist만 조회합니다. <br> 타인의 playlist를 조회할 수 있습니다.'
      response(200, 'successful') do
        let(:id) { @playlist.id }
        run_test!
      end
    end

    put 'update playlist' do
      tags 'playlist'
      description 'playlist를 수정합니다. title은 필수입니다. <br> owner(polymorphic. group or user)의 playlist를 수정합니다. <br> my_album 타입의 playlist만 수정할 수 있습니다.'

      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true
      parameter name: :owner_id, in: :query, type: :integer, description: 'user_id or group_id', required: true
      parameter name: :owner_type, in: :query, type: :string, description: 'user or group', required: true
      parameter name: :playlist, in: :body, schema: { '$ref' => '#/components/schemas/playlist_object' }

      response(200, 'successful') do
        let(:id) { @playlist.id }
        let(:owner_id) { @user.id }
        let(:owner_type) { "user" }
        let(:Authorization) { @user.id }
        let(:playlist) { { title: 'playlist title' } }

        run_test!
      end
    end

    delete 'delete playlist' do
      tags 'playlist'
      parameter name: :owner_id, in: :query, type: :integer, description: 'user_id or group_id', required: true
      parameter name: :owner_type, in: :query, type: :string, description: 'user or group', required: true
      parameter name: :Authorization, in: :header, type: :integer, description: '사용자 인증(user_id 입력)', required: true

      description 'playlist을 삭제합니다.'
      response(204, 'successful') do
        let(:id) { @playlist.id }
        let(:owner_id) { @user.id }
        let(:owner_type) { "user" }
        let(:Authorization) { @user.id }

        run_test!
      end
    end
  end
end

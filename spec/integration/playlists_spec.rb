require 'swagger_helper'

RSpec.describe 'playlists', type: :request do
  path '/playlists' do
    get 'list playlists' do
      tags 'playlist'
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'playlist 리스트를 가져옵니다. my_album(내앨범) 타입의 playlist만 조회합니다. <br> 타인의 playlist를 조회할 수 있습니다.'
      
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post 'create playlist' do
      tags 'playlist'
      parameter name: :playlist, in: :body, schema: { '$ref' => '#/components/schemas/playlist_object' }
      parameter name: 'owner_id', in: :query, type: :integer, description: 'user_id or group_id'
      parameter name: 'owner_type', in: :query, type: :integer, description: 'user or group'

      description 'playlist를 생성합니다. title은 필수입니다. <br> owner(polymorphic. group or user)의 playlist를 생성합니다. <br> my_album 타입의 playlist만 생성할 수 있습니다.'
      response 200, 'playlist created' do
        let(:playlist) { { name: 'playlist name' } }
        run_test!
      end

      response 422, 'failed' do
        let(:playlist) { { name: '' } }
        run_test!
      end
    end
  end

  path '/playlists/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get 'show playlist' do
      tags 'playlist'
      description '개별 playlist 리스트를 가져옵니다. my_album(내앨범) 타입의 playlist만 조회합니다. <br> 타인의 playlist를 조회할 수 있습니다.'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put 'update playlist' do
      tags 'playlist'
      description 'playlist를 수정합니다. title은 필수입니다. <br> owner(polymorphic. group or user)의 playlist를 수정합니다. <br> my_album 타입의 playlist만 수정할 수 있습니다.'

      parameter name: 'owner_id', in: :query, type: :integer, description: 'user_id or group_id'
      parameter name: 'owner_type', in: :query, type: :integer, description: 'user or group'
      parameter name: :playlist, in: :body, schema: { '$ref' => '#/components/schemas/playlist_object' }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete 'delete playlist' do
      tags 'playlist'
      parameter name: 'owner_id', in: :query, type: :integer, description: 'user_id or group_id'
      parameter name: 'owner_type', in: :query, type: :integer, description: 'user or group'
      
      description 'playlist을 삭제합니다.'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end

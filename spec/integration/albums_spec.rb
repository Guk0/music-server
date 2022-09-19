require 'swagger_helper'

RSpec.describe 'albums', type: :request do
  path '/albums' do
    get 'list albums' do
      parameter name: 'page', in: :query, type: :string, description: 'page', example: 1, required: false
      description 'album 리스트를 가져옵니다.'
      
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

    post 'create album' do
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          album: {
            type: :object,
            properties: {
              title: { type: :string, example: "growing up" },
              artist_id: { type: :integer, example: 1 }            
            }
          }
        },
        required: [ 'title', 'artist_id' ]
      }

      description '앨범을 생성합니다. artist_id와 title은 필수입니다.'
      response 200, 'album created' do
        let(:album) { { title: 'album title', artist_id: 1 } }
        run_test!
      end

      response 422, 'album failed' do
        let(:album) { { title: 'album title' } }
        run_test!
      end
    end
  end

  path '/albums/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get 'show album' do
      description '개별 album을 조회합니다. artist와 track list를 포함합니다.'
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

    put 'update album' do
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          album: {
            type: :object,
            properties: {
              title: { type: :string, example: "growing up" },
              artist_id: { type: :integer, example: 1 }            
            }
          }
        },
        required: [ 'title', 'artist_id' ]
      }

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

    delete 'delete album' do
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
